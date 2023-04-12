import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/providers/reservations_provider.dart';
import 'package:mobile_app/views/reservations_browsing/reservations_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'reservations_list_test.mocks.dart';

@GenerateMocks([ReservationsStorageProvider])
void main() {
  late MockReservationsStorageProvider mockReservationsStorageProvider;
  setUp(() {
    mockReservationsStorageProvider = MockReservationsStorageProvider();
  });

  final reservationsFromProvider = <Reservation>[
    Reservation(
      eventId: 1,
      title: 'titleq',
      startTime: 0,
      endTime: 1000,
      address: 'address1',
      name: 'name1',
      reservationToken: '123',
      placeId: 1,
    ),
    Reservation(
      eventId: 2,
      title: 'title2',
      startTime: 123,
      endTime: 12345,
      address: 'address2',
      name: 'name2',
      reservationToken: '19241984',
      placeId: 2,
    ),
  ];

  void arrangeReservationsFromStorageProviderReturnsReservations() {
    when(mockReservationsStorageProvider.readReservations())
        .thenAnswer((_) async => reservationsFromProvider);
  }

  void arrangeReservationsFromStorageProviderReturnsReservationsAfterWait() {
    when(mockReservationsStorageProvider.readReservations())
        .thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return reservationsFromProvider;
    });
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Demo',
      home: ChangeNotifierProvider<ReservationsStorageProvider>(
        create: (context) => mockReservationsStorageProvider,
        child: const ReservationsList(),
      ),
    );
  }

  group('reservations list', () {
    testWidgets('title displayed', (widgetTester) async {
      arrangeReservationsFromStorageProviderReturnsReservations();
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Your reservations'), findsOneWidget);
    });

    testWidgets('loading indicator is displayed while waiting for reservations',
        (widgetTester) async {
      arrangeReservationsFromStorageProviderReturnsReservationsAfterWait();
      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    });

    testWidgets('events are displayed', (widgetTester) async {
      arrangeReservationsFromStorageProviderReturnsReservations();

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pump();

      for (final reservation in reservationsFromProvider) {
        expect(find.text(reservation.title), findsOneWidget);
      }
    });
  });
}
