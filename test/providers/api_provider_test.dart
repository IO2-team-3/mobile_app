import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import 'api_provider_test.mocks.dart';

@GenerateMocks([Openapi, EventApi, CategoriesApi])
void main() {
  final testEvent = (EventBuilder()
        ..id = 1
        ..freePlace = 2
        ..title = 'event-title'
        ..startTime = 123
        ..endTime = 12342350
        ..name = 'event-name'
        ..status = EventStatus.done
        ..longitude = '123.445'
        ..latitude = '12.2235'
        ..maxPlace = 10
        ..categories = ListBuilder<Category>(
          [
            (CategoryBuilder()
                  ..id = 1
                  ..name = 'category-name')
                .build(),
          ],
        ))
      .build();

  final testEventWithPlaces = (EventWithPlacesBuilder()
        ..id = 1
        ..freePlace = 2
        ..title = 'event-title'
        ..startTime = 123
        ..endTime = 12342350
        ..name = 'event-name'
        ..status = EventStatus.done
        ..longitude = '123.445'
        ..latitude = '12.2235'
        ..maxPlace = 10
        ..categories = ListBuilder<Category>(
          [
            (CategoryBuilder()
                  ..id = 1
                  ..name = 'category-name')
                .build(),
          ],
        )
        ..places = ListBuilder<Place>([]))
      .build();
  group('APIProvider', () {
    late Openapi mockApi;
    late APIProvider apiProvider;
    late MockEventApi mockEventApi;
    late MockCategoriesApi mockCategoriesApi;

    setUp(() {
      mockApi = MockOpenapi();
      mockEventApi = MockEventApi();
      mockCategoriesApi = MockCategoriesApi();
      apiProvider = APIProvider(api: mockApi);
    });

    test('fetchEventsList should call getEvents on EventApi', () async {
      // arrange
      final mockResponse = Response<BuiltList<Event>>(
        data: BuiltList([]),
        requestOptions: RequestOptions(path: ''),
      );
      when(mockApi.getEventApi()).thenReturn(mockEventApi);
      when(mockEventApi.getEvents()).thenAnswer((_) async => mockResponse);

      // act
      await apiProvider.fetchEventsList();

      // assert
      verify(mockEventApi.getEvents()).called(1);
    });

    test(
        'fetchEventById should call getEventById on EventApi with the correct id',
        () async {
      // arrange
      const eventId = 123;
      final mockResponse = Response<EventWithPlaces>(
        data: testEventWithPlaces,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockApi.getEventApi()).thenReturn(mockEventApi);
      when(mockEventApi.getEventById(id: eventId))
          .thenAnswer((_) async => mockResponse);

      // act
      await apiProvider.fetchEventById(id: eventId);

      // assert
      verify(mockEventApi.getEventById(id: eventId)).called(1);
    });

    test('fetchMyEvents should call getMyEvents on EventApi', () async {
      // arrange
      final mockResponse = Response<BuiltList<Event>>(
        data: BuiltList([testEvent]),
        requestOptions: RequestOptions(path: ''),
      );
      when(mockApi.getEventApi()).thenReturn(mockEventApi);
      when(mockEventApi.getMyEvents()).thenAnswer((_) async => mockResponse);

      // act
      await apiProvider.fetchMyEvents();

      // assert
      verify(mockEventApi.getMyEvents()).called(1);
    });

    test('fetchCategoriesList should call getCategories on CategoriesApi',
        () async {
      // arrange
      final mockResponse = Response<BuiltList<Category>>(
        data: BuiltList([]),
        requestOptions: RequestOptions(path: ''),
      );
      when(mockApi.getCategoriesApi()).thenReturn(mockCategoriesApi);
      when(mockCategoriesApi.getCategories())
          .thenAnswer((_) async => mockResponse);

      // act
      await apiProvider.fetchCategoriesList();

      // assert
      verify(mockCategoriesApi.getCategories()).called(1);
    });

    test(
        'fetchEventByCategoryId should call getByCategory on EventApi with the correct categoryId',
        () async {
      // arrange
      const categoryId = 456;
      final mockResponse = Response<BuiltList<Event>>(
        data: BuiltList([]),
        requestOptions: RequestOptions(path: ''),
      );
      when(mockApi.getEventApi()).thenReturn(mockEventApi);
      when(mockEventApi.getByCategory(categoryId: categoryId))
          .thenAnswer((_) async => mockResponse);

      // act
      await apiProvider.fetchEventByCategoryId(categoryId: categoryId);

      // assert
      verify(mockEventApi.getByCategory(categoryId: categoryId)).called(1);
    });
  });
}
