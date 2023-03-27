// TODO
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/views/events_browsing/filtering/filtered_events_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:openapi/openapi.dart';

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
          ..title = 'event-title'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '123.445'
          ..latitude = '12.2235'
          ..categories = ListBuilder<Category>(
            [
              categoriesById[0],
            ],
          ))
        .build(),
    (eventBuilder
          ..id = 1
          ..freePlace = 2
          ..title = 'event-title'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '123.445'
          ..latitude = '12.2235'
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
          ..title = 'event-title'
          ..startTime = 123
          ..endTime = 12342350
          ..name = 'event-name'
          ..status = EventStatus.done
          ..longitude = '123.445'
          ..latitude = '12.2235'
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

    when(mockAPIProvider.fetchEventByCategoryId(categoryId: 0)).thenAnswer(
        (_) async => Response(
            data: eventsWithCategoryId1, requestOptions: RequestOptions()));

    when(mockAPIProvider.fetchEventByCategoryId(categoryId: 0)).thenAnswer(
        (_) async => Response(
            data: eventsWithCategoryId2, requestOptions: RequestOptions()));
  }

  group('test fetching events with desired categories', () {
    // test('categorieIds: 0', () async {
    //   arrangeAPIProviderReturnsEventsByCategoryId();
    // UnmodifiableListView<Category> desiredCategories =
    //     UnmodifiableListView<Category>([categoriesById[0]]);
    // Future<Response<BuiltList<Event>>> futureAllEvents = Future(() => Response(data: allEvents, requestOptions: RequestOptions()));

    // List<Event> eventsWithDesiredCategories = await fetchEventsWithDesiredCategories(mockAPIProvider, desiredCategories, futureAllEvents);
    // expect(eventsWithDesiredCategories.length, 2);
    // expect(eventsWithDesiredCategories, matcher)
    // });
  });
}
