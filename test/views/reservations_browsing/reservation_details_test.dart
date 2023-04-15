import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/reservations_provider.dart';
import 'package:mobile_app/views/reservations_browsing/reservation_details.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'reservation_details_test.mocks.dart';

@GenerateMocks([ReservationsStorageProvider, APIProvider])
void main() {
  late MockReservationsStorageProvider mockReservationStorageProvider;
  late MockAPIProvider mockApiProvider;
  final reservationWithPlaceSchema = Reservation(
    eventId: 1,
    title: 'test-title',
    startTime: 0,
    endTime: 10000,
    address: 'test-address',
    name: 'test-name',
    reservationToken: '12398522359835923952398r',
    placeId: 1,
    placeSchema:
        'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAQMAAAD+wSzIAAAABlBMVEX///+/v7+jQ3Y5AAAADklEQVQI12P4AIX8EAgALgAD/aNpbtEAAAAASUVORK5CYII',
  );

  setUp(() {
    mockReservationStorageProvider = MockReservationsStorageProvider();
    mockApiProvider = MockAPIProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<APIProvider>(
              create: (context) => mockApiProvider),
          ChangeNotifierProvider<ReservationsStorageProvider>(
              create: (context) => mockReservationStorageProvider),
        ],
        child: ReservationDetails(
          reservation: reservationWithPlaceSchema,
        ),
      ),
    );
  }

  group('reservation details UI', () {
    testWidgets('title diplayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text(reservationWithPlaceSchema.title), findsOneWidget);
    });

    testWidgets('place button displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.chair), findsOneWidget);
    });

    testWidgets('cancel button displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
      expect(find.text('Cancel reservation'), findsOneWidget);
    });

    testWidgets('event info displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('Start date:'), findsOneWidget);
      expect(find.textContaining('End date:'), findsOneWidget);
      expect(find.text('test-address'), findsOneWidget);
    });
  });

  group('canceling dialog', () {
    testWidgets('title displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pump();

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is AlertDialog &&
                widget.title is Text &&
                (widget.title as Text).data == 'Cancel reservation',
          ),
          findsOneWidget);
    });

    testWidgets('warning diplayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pump();

      expect(find.text('You are about to cancel the reservation.'),
          findsOneWidget);
      expect(find.text('Are you sure? This action cannot be reversed.'),
          findsOneWidget);
    });

    testWidgets('go back button displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pump();

      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextButton &&
              widget.child is Text &&
              (widget.child as Text).data == 'Go back'),
          findsOneWidget);
    });

    testWidgets('confirm button displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pump();

      expect(
          find.byWidgetPredicate((widget) =>
              widget is TextButton &&
              widget.child is Text &&
              (widget.child as Text).data == 'Confirm'),
          findsOneWidget);
    });
  });
}
