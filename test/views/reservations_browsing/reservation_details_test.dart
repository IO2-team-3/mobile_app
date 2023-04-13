import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/views/reservations_browsing/reservation_details.dart';

void main() {
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

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: ReservationDetails(
        reservation: reservationWithPlaceSchema,
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
}
