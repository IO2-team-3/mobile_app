import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/views/events_browsing/events_list.dart';
import 'package:mockito/annotations.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

import 'events_list_test.mocks.dart';

@GenerateMocks([EventsCacheProvider])
void main() {
  late MockEventsCacheProvider mockEventsCacheProvider;
  setUp(() {
    mockEventsCacheProvider = MockEventsCacheProvider();
  });

  final eventsFromProvider = ListBuilder<Event>(
    [
      (EventBuilder()
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
                (CategoryBuilder()
                      ..id = 1
                      ..name = 'category-name')
                    .build(),
              ],
            ))
          .build(),
    ],
  ).build();

  void arrangeEventsCacheProviderReturnsEvents() {
    when(mockEventsCacheProvider.getAllEvents()).thenAnswer((_) async =>
        Response(data: eventsFromProvider, requestOptions: RequestOptions()));
  }

  void arrangeEventsCacheProviderReturnsEventsAfterWait() {
    when(mockEventsCacheProvider.getAllEvents()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return Response(
          data: eventsFromProvider, requestOptions: RequestOptions());
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: ChangeNotifierProvider<EventsCacheProvider>(
        create: (context) => mockEventsCacheProvider,
        child: const EventsList(),
      ),
    );
  }

  group('events list', () {
    testWidgets('title is displayed', (widgetTester) async {
      arrangeEventsCacheProviderReturnsEvents();
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Events'), findsOneWidget);
    });

    testWidgets('loading indicator is displayed while waiting for events',
        (widgetTester) async {
      arrangeEventsCacheProviderReturnsEventsAfterWait();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    });

    testWidgets('events are displayed', (widgetTester) async {
      arrangeEventsCacheProviderReturnsEvents();

      await widgetTester.pumpWidget(createWidgetUnderTest());

      await widgetTester.pump();

      for (final event in eventsFromProvider) {
        expect(find.text(event.title!), findsOneWidget);
      }
    });
  });
}
