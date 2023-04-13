import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/providers/reservations_provider.dart';
import 'package:mobile_app/views/reservations_browsing/reservation_tile.dart';
import 'package:provider/provider.dart';

class ReservationsList extends StatelessWidget {
  const ReservationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your reservations'),
      ),
      body: FutureBuilder<List<Reservation>>(
        future: context.read<ReservationsStorageProvider>().readReservations(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var reservationsList = snapshot.data!;
          return ListView.builder(
            itemCount: reservationsList.length,
            itemBuilder: (_, index) => ReservationTile(
              reservation: reservationsList[index],
            ),
          );
        },
      ),
    );
  }
}
