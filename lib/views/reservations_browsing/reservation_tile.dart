import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/views/reservations_browsing/reservation_details.dart';

class ReservationTile extends StatelessWidget {
  final Reservation reservation;
  const ReservationTile({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(reservation.title),
              subtitle: Text(
                reservation.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('MORE...'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ReservationDetails(
                            reservation: reservation,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
