import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/views/reservations_browsing/reservation_tile.dart';

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
      home: ReservationTile(reservation: reservationWithPlaceSchema),
    );
  }

  group('reservation tile', () {
    testWidgets('more widgets is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('MORE...'), findsOneWidget);
    });

    testWidgets('event name & title are displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text(reservationWithPlaceSchema.name), findsOneWidget);
      expect(find.text(reservationWithPlaceSchema.title), findsOneWidget);
    });
  });
}
