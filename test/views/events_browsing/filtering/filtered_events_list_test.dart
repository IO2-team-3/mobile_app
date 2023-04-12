import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/event_tile.dart';
import 'package:mobile_app/views/events_browsing/filtering/filtered_events_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import 'filtered_events_list_test.mocks.dart';

@GenerateMocks([EventsCacheProvider, APIProvider, SearchQueryProvider])
void main() {
  late MockEventsCacheProvider mockEventsCacheProvider;
  late MockAPIProvider mockAPIProvider;
  late MockSearchQueryProvider mockSearchQueryProvider;

  setUp(() {
    mockEventsCacheProvider = MockEventsCacheProvider();
    mockAPIProvider = MockAPIProvider();
    mockSearchQueryProvider = MockSearchQueryProvider();
  });

  EventBuilder eventBuilder = EventBuilder();
  CategoryBuilder categoryBuilder = CategoryBuilder();

  final categoriesById = [
    (categoryBuilder
          ..id = 0
          ..name = 'category-name')
        .build(),
    (categoryBuilder
          ..id = 1
          ..name = 'category-name')
        .build(),
    (categoryBuilder
          ..id = 2
          ..name = 'category-name')
        .build(),
  ];

  final allEvents = ListBuilder<Event>([
    (eventBuilder
          ..id = 0
          ..freePlace = 2
          ..title = 'eventloremtitle'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '5.0'
          ..latitude = '6.0'
          ..maxPlace = 10
          ..categories = ListBuilder<Category>(
            [
              categoriesById[0],
            ],
          ))
        .build(),
    (eventBuilder
          ..id = 1
          ..freePlace = 2
          ..title = 'event-title-lo'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '6.0'
          ..latitude = '5.55'
          ..categories = ListBuilder<Category>(
            [
              categoriesById[0],
              categoriesById[1],
            ],
          ))
        .build(),
    (eventBuilder
          ..id = 2
          ..freePlace = 2
          ..title = 'event-titleloremipsum'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '8.5'
          ..latitude = '-5.0'
          ..categories = ListBuilder<Category>(
            [
              categoriesById[2],
            ],
          ))
        .build(),
  ]).build();

  final eventsWithCategoryId0 = ListBuilder<Event>(
    [allEvents[0], allEvents[1]],
  ).build();

  final eventsWithCategoryId1 = ListBuilder<Event>(
    [allEvents[1]],
  ).build();

  final eventsWithCategoryId2 = ListBuilder<Event>(
    [allEvents[2]],
  ).build();

  void arrangeAPIProviderReturnsEventsByCategoryId() {
    when(mockAPIProvider.fetchEventByCategoryId(categoryId: 0)).thenAnswer(
        (_) async => Response(
            data: eventsWithCategoryId0, requestOptions: RequestOptions()));

    when(mockAPIProvider.fetchEventByCategoryId(categoryId: 1)).thenAnswer(
        (_) async => Response(
            data: eventsWithCategoryId1, requestOptions: RequestOptions()));

    when(mockAPIProvider.fetchEventByCategoryId(categoryId: 2)).thenAnswer(
        (_) async => Response(
            data: eventsWithCategoryId2, requestOptions: RequestOptions()));
  }

  void arrangeSearchQueryProviderSearchRadiusDefined(
      double lat, double long, double distInKm, String eventName) {
    when(mockSearchQueryProvider.eventName).thenReturn(eventName);
    when(mockSearchQueryProvider.distanceInKm).thenReturn(distInKm);
    when(mockSearchQueryProvider.currentLocation).thenReturn(
        Location(latitude: lat, longitude: long, timestamp: DateTime(0)));
  }

  void arrangeSearchQueryProviderReturnsCategories(
      UnmodifiableListView<Category> categories) {
    when(mockSearchQueryProvider.categories).thenReturn(categories);
  }

  void arrangeEventsCacheProviderReturnsEvents() {
    when(mockEventsCacheProvider.getAllEvents()).thenAnswer((_) async =>
        Response(data: allEvents, requestOptions: RequestOptions()));
  }

  group('test fetching events with desired categories', () {
    late Future<Response<BuiltList<Event>>> futureAllEvents;
    setUp(() {
      arrangeAPIProviderReturnsEventsByCategoryId();
      futureAllEvents = Future(
          () => Response(data: allEvents, requestOptions: RequestOptions()));
    });
    test('categoryIds: 0', () async {
      UnmodifiableListView<Category> desiredCategories =
          UnmodifiableListView<Category>([categoriesById[0]]);

      List<Event> eventsWithDesiredCategories =
          await fetchEventsWithDesiredCategories(
              mockAPIProvider, desiredCategories, futureAllEvents);

      expect(eventsWithDesiredCategories.length, 2);
      expect(
          const DeepCollectionEquality.unordered().equals(
            eventsWithDesiredCategories,
            [allEvents[0], allEvents[1]],
          ),
          true);
    });

    test('categoryIds: 0, 1', () async {
      UnmodifiableListView<Category> desiredCategories =
          UnmodifiableListView<Category>(
              [categoriesById[0], categoriesById[1]]);

      List<Event> eventsWithDesiredCategories =
          await fetchEventsWithDesiredCategories(
              mockAPIProvider, desiredCategories, futureAllEvents);

      expect(eventsWithDesiredCategories.length, 2);
      expect(
          const DeepCollectionEquality.unordered().equals(
            eventsWithDesiredCategories,
            [allEvents[0], allEvents[1]],
          ),
          true);
    });

    test('categoryIds: 1, 2', () async {
      UnmodifiableListView<Category> desiredCategories =
          UnmodifiableListView<Category>(
              [categoriesById[1], categoriesById[2]]);

      List<Event> eventsWithDesiredCategories =
          await fetchEventsWithDesiredCategories(
              mockAPIProvider, desiredCategories, futureAllEvents);

      expect(eventsWithDesiredCategories.length, 2);
      expect(
          const DeepCollectionEquality.unordered().equals(
            eventsWithDesiredCategories,
            [allEvents[1], allEvents[2]],
          ),
          true);
    });

    test('categoryIds: 1, 2, 3', () async {
      UnmodifiableListView<Category> desiredCategories =
          UnmodifiableListView<Category>(
              [categoriesById[0], categoriesById[1], categoriesById[2]]);

      List<Event> eventsWithDesiredCategories =
          await fetchEventsWithDesiredCategories(
              mockAPIProvider, desiredCategories, futureAllEvents);

      expect(eventsWithDesiredCategories.length, 3);
      expect(
          const DeepCollectionEquality.unordered().equals(
            eventsWithDesiredCategories,
            [allEvents[0], allEvents[1], allEvents[2]],
          ),
          true);
    });
  });

  group('test filtering events', () {
    test('test filtering with no predicate', () {
      arrangeSearchQueryProviderSearchRadiusDefined(0, 0, double.maxFinite, '');

      List<Event> filtered =
          filterEvents(allEvents.toList(), mockSearchQueryProvider);
      expect(const IterableEquality().equals(filtered, allEvents), true);
    });

    test('test filtering with by name', () {
      arrangeSearchQueryProviderSearchRadiusDefined(
          0, 0, double.maxFinite, 'lorem');

      List<Event> filtered =
          filterEvents(allEvents.toList(), mockSearchQueryProvider);
      expect(
          const IterableEquality()
              .equals(filtered, [allEvents[0], allEvents[2]]),
          true);
    });

    test('test filtering with by distance', () {
      arrangeSearchQueryProviderSearchRadiusDefined(0, 0, 1000, '');

      List<Event> filtered =
          filterEvents(allEvents.toList(), mockSearchQueryProvider);
      expect(
          const IterableEquality()
              .equals(filtered, [allEvents[0], allEvents[1]]),
          true);
    });

    test('test filtering with by distance and name', () {
      arrangeSearchQueryProviderSearchRadiusDefined(0, 0, 1000, 'loremtitle');

      List<Event> filtered =
          filterEvents(allEvents.toList(), mockSearchQueryProvider);
      expect(const IterableEquality().equals(filtered, [allEvents[0]]), true);
    });
  });

  group('test UI', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        title: 'Demo',
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<APIProvider>(
              create: (context) => mockAPIProvider,
            ),
            ChangeNotifierProvider<EventsCacheProvider>(
              create: (context) => mockEventsCacheProvider,
            ),
            ChangeNotifierProvider<SearchQueryProvider>(
              create: (context) => mockSearchQueryProvider,
            ),
          ],
          child: const FilteredEventList(),
        ),
      );
    }

    testWidgets('app bar title is displayed', (widgetTester) async {
      arrangeAPIProviderReturnsEventsByCategoryId();
      arrangeEventsCacheProviderReturnsEvents();
      arrangeSearchQueryProviderSearchRadiusDefined(0, 0, 0, '');
      arrangeSearchQueryProviderReturnsCategories(
          UnmodifiableListView<Category>([]));

      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Filtered events'), findsOneWidget);
    });

    testWidgets('filtered events are displayed', (widgetTester) async {
      arrangeAPIProviderReturnsEventsByCategoryId();
      arrangeEventsCacheProviderReturnsEvents();
      arrangeSearchQueryProviderSearchRadiusDefined(0, 0, 1000, 'event');
      arrangeSearchQueryProviderReturnsCategories(
          UnmodifiableListView<Category>([categoriesById[1]]));

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      expect(find.byType(EventTile), findsOneWidget);
      expect(find.text(allEvents[1].title), findsOneWidget);
      expect(find.text(allEvents[1].name), findsOneWidget);
    });
  });
}
