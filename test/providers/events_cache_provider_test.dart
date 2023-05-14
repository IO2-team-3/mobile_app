import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';

import 'events_cache_provider_test.mocks.dart';

@GenerateMocks([APIProvider])
void main() {
  group('EventsCacheProvider', () {
    late EventsCacheProvider cacheProvider;
    late MockAPIProvider mockAPIProvider;

    setUp(() {
      mockAPIProvider = MockAPIProvider();
      cacheProvider = EventsCacheProvider(apiProvider: mockAPIProvider);
    });

    test('refreshAllEvents should update allEvents and lastFetchTime',
        () async {
      final eventsList = BuiltList<Event>([]);
      when(mockAPIProvider.fetchEventsList()).thenAnswer((_) async =>
          Response(data: eventsList, requestOptions: RequestOptions()));

      await cacheProvider.refreshAllEvents(false);

      expect(cacheProvider.allEvents!.data, eventsList);
      expect(
          cacheProvider.lastFetchTime
              .isBefore(DateTime.now().add(const Duration(microseconds: 1))),
          isTrue);
    });

    test(
        'getAllEvents should return allEvents when cache is valid and forceRefresh is false',
        () async {
      final eventsList = BuiltList<Event>([]);
      cacheProvider.allEvents =
          Response(data: eventsList, requestOptions: RequestOptions());
      cacheProvider.lastFetchTime = DateTime.now();

      final response = await cacheProvider.getAllEvents();

      expect(response.data, eventsList);
    });

    test(
        'getAllEvents should call refreshAllEvents and return allEvents when cache is invalid and forceRefresh is false',
        () async {
      final eventsList = BuiltList<Event>([]);
      when(mockAPIProvider.fetchEventsList()).thenAnswer((_) async =>
          Response(data: eventsList, requestOptions: RequestOptions()));

      cacheProvider.allEvents = null;
      cacheProvider.lastFetchTime =
          DateTime.now().subtract(const Duration(minutes: 11));

      final response = await cacheProvider.getAllEvents();

      expect(cacheProvider.allEvents!.data, eventsList);
      expect(response.data, eventsList);
    });

    test(
        'getAllEvents should call refreshAllEvents and return allEvents when forceRefresh is true',
        () async {
      final eventsList = BuiltList<Event>([]);
      when(mockAPIProvider.fetchEventsList()).thenAnswer((_) async =>
          Response(data: eventsList, requestOptions: RequestOptions()));

      cacheProvider.allEvents = Response(
          data: BuiltList<Event>([]), requestOptions: RequestOptions());
      cacheProvider.lastFetchTime = DateTime.now();

      final response = await cacheProvider.getAllEvents(forceRefresh: true);

      expect(cacheProvider.allEvents!.data, eventsList);
      expect(response.data, eventsList);
    });
  });
}
