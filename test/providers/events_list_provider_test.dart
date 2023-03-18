import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/providers/events_list_provider.dart';
import 'package:mobile_app/services/events_list_service.dart';
import 'package:mockito/annotations.dart';

import 'events_list_provider_test.mocks.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([EventsListService])
void main() {
  late EventsListProvider subject;
  late MockEventsListService mockEventsListService;
  setUp(() {
    mockEventsListService = MockEventsListService();
    subject = EventsListProvider(eventsListService: mockEventsListService);
  });
  group('description', () {
    test('initial values are correct', () {
      expect(subject.events, []);
      expect(subject.isLoading, false);
    });
  });

  group('getArticles', () {
    final eventsFromService = [
      Event(
        id: 1,
        freePlace: 2,
        title: 'abc',
        startTime: 123,
        endTime: 124,
        name: 'name',
        status: 'status',
        categories: [
          Category(id: 1, name: 'name'),
        ],
      ),
    ];

    void arrangeEventsListServiceReturnsEvents() {
      when(mockEventsListService.fetchEventsList())
          .thenAnswer((_) async => eventsFromService);
    }

    test('gets articles using the EventsListService', () async {
      arrangeEventsListServiceReturnsEvents();
      await subject.getEventsList();
      verify(mockEventsListService.fetchEventsList()).called(1);
    });

    test(
        'indicates loading of data, sets articles to the ones from the service, indicates thtat the data is not being loaded anymore',
        () async {
      arrangeEventsListServiceReturnsEvents();
      final future = subject.getEventsList();
      expect(subject.isLoading, true);
      await future;
      expect(subject.events, eventsFromService);
      expect(subject.isLoading, false);
    });
  });
}
