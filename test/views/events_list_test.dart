import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/providers/events_list_provider.dart';
import 'package:mobile_app/views/events_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile_app/services/events_list_service.dart';
import 'package:provider/provider.dart';

import 'events_list_test.mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_app/models/event.dart';

@GenerateMocks([EventsListService])
void main() {
  late MockEventsListService mockEventsListService;
  setUp(() {
    mockEventsListService = MockEventsListService();
  });

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

  void arrangeEventsListServiceReturnsEventsAfterWait() {
    when(mockEventsListService.fetchEventsList()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return eventsFromService;
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: ChangeNotifierProvider(
        create: (_) =>
            EventsListProvider(eventsListService: mockEventsListService),
        child: const EventsList(),
      ),
    );
  }

  group('events list', () {
    testWidgets('title is displayed', (widgetTester) async {
      arrangeEventsListServiceReturnsEvents();
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Events'), findsOneWidget);
    });

    testWidgets('loading indicator is displayed while waiting for events',
        (widgetTester) async {
      arrangeEventsListServiceReturnsEventsAfterWait();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    });

    testWidgets('events are displayed', (widgetTester) async {
      arrangeEventsListServiceReturnsEvents();

      await widgetTester.pumpWidget(createWidgetUnderTest());

      await widgetTester.pump();

      for (final event in eventsFromService) {
        expect(find.text(event.title), findsOneWidget);
      }
    });
  });

  group('event tile', () {
    final testEvent = Event(
      id: 1,
      freePlace: 2,
      title: 'abc',
      startTime: 123,
      endTime: 124,
      name: 'name',
      status: 'status',
      categories: [
        Category(id: 1, name: 'cat1'),
        Category(id: 2, name: 'cat2'),
      ],
    );

    Widget createWidgetUnderTest() {
      return MaterialApp(
        title: 'Demo',
        home: EventTile(event: testEvent),
      );
    }

    testWidgets('reserve & learn more buttons are displayed',
        (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text(testEvent.title), findsOneWidget);

      expect(find.text('RESERVE'), findsOneWidget);
      expect(find.text('LEARN MORE'), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
    });

    testWidgets('categories are displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('cat1'), findsOneWidget);
      expect(find.text('cat2'), findsOneWidget);
    });
  });

  group('event details', () {
    final testEvent = Event(
      id: 1,
      freePlace: 2,
      title: 'abc',
      startTime: 123,
      endTime: 1234234234,
      name: 'name',
      status: 'status',
      categories: [
        Category(id: 1, name: 'cat1'),
        Category(id: 2, name: 'cat2'),
      ],
    );

    Widget createWidgetUnderTest() {
      return MaterialApp(
        title: 'Demo',
        home: EventDetails(event: testEvent),
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

      var startDate =
          DateTime.fromMillisecondsSinceEpoch(testEvent.startTime * 1000);
      var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
      var startDateStrHM = DateFormat.jm().format(startDate);

      expect(find.textContaining(startDateStrYMMD), findsOneWidget);
      expect(find.textContaining(startDateStrHM), findsOneWidget);
    });

    testWidgets('end date is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('End date:'), findsOneWidget);

      var endDate =
          DateTime.fromMillisecondsSinceEpoch(testEvent.endTime * 1000);
      var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
      var endDateStrHM = DateFormat.jm().format(endDate);

      expect(find.textContaining(endDateStrYMMD), findsOneWidget);
      expect(find.textContaining(endDateStrHM), findsOneWidget);
    });
  });
}
