import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/views/events_browsing/event_details.dart';
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
  group('event details', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        title: 'Demo',
        home: EventDetails(event: eventsFromService[0]),
      );
    }

    testWidgets('reserve button is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Reserve'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('start date is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('Start date:'), findsOneWidget);

      var startDate = DateTime.fromMillisecondsSinceEpoch(
          eventsFromService[0].startTime * 1000);
      var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
      var startDateStrHM = DateFormat.jm().format(startDate);

      expect(find.textContaining(startDateStrYMMD), findsOneWidget);
      expect(find.textContaining(startDateStrHM), findsOneWidget);
    });

    testWidgets('end date is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('End date:'), findsOneWidget);

      var endDate = DateTime.fromMillisecondsSinceEpoch(
          eventsFromService[0].endTime * 1000);
      var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
      var endDateStrHM = DateFormat.jm().format(endDate);

      expect(find.textContaining(endDateStrYMMD), findsOneWidget);
      expect(find.textContaining(endDateStrHM), findsOneWidget);
    });
  });
}
