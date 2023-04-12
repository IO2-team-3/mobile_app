import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/views/events_browsing/event_tile.dart';
import 'package:openapi/openapi.dart';

void main() {
  final eventsFromService = ListBuilder<Event>(
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
            ..maxPlace = 10
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

  group('event tile', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        title: 'Demo',
        home: EventTile(event: eventsFromService[0]),
      );
    }

    testWidgets('learn more button is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text(eventsFromService[0].title), findsOneWidget);

      expect(find.text('LEARN MORE'), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(1));
    });

    testWidgets('categories are displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(
          find.text(eventsFromService[0].categories[0].name), findsOneWidget);
    });
  });
}
