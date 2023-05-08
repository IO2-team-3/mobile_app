import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/views/reservations_browsing/place_info.dart';

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
      home: PlaceInfo(reservation: reservationWithPlaceSchema),
    );
  }

  group('place info visuals', () {
    testWidgets('title is displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Place info'), findsOneWidget);
    });

    testWidgets('place info displayed', (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Your place:'), findsOneWidget);
      expect(find.text('Place 1'), findsOneWidget);
    });
  });
}
