import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('group name', () {
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
  });
}
