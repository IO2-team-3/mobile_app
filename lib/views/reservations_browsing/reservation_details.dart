import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/reservations_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../common/place_information.dart';

class ReservationDetails extends StatelessWidget {
  final Reservation reservation;
  const ReservationDetails({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    var startDate =
        DateTime.fromMillisecondsSinceEpoch(reservation.startTime * 1000);
    var endDate =
        DateTime.fromMillisecondsSinceEpoch(reservation.endTime * 1000);

    var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
    var startDateStrHM = DateFormat.jm().format(startDate);
    var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
    var endDateStrHM = DateFormat.jm().format(endDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(reservation.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.chair),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceInformation(
                  addressWidget: Text(
                    reservation.address,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showConfirmCancelingDialog(context, reservation);
        },
        label: const Text('Cancel reservation'),
        icon: const Icon(Icons.cancel_outlined),
        backgroundColor: const Color.fromARGB(255, 227, 67, 52),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: QrImage(
                data: reservation.reservationToken,
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  reservation.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 22, 180, 207)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Start date: $startDateStrYMMD'),
                          Text(startDateStrHM),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 22, 180, 207)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('End date: $endDateStrYMMD'),
                          Text(endDateStrHM),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PlaceInformation(
                addressWidget: Text(
                  reservation.address,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmCancelingDialog(
      BuildContext context, Reservation reservation) async {
    final reservationStorageProvider =
        context.read<ReservationsStorageProvider>();
    final apiProvider = context.read<APIProvider>();
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel reservation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('You are about to cancel the reservation.'),
                Text('Are you sure? This action cannot be reversed.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await reservationStorageProvider.removeReservation(
                      reservation.eventId, reservation.placeId);
                } on PathNotFoundException {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Couldn't cancel reservation!",
                      ),
                      backgroundColor: Color.fromARGB(255, 227, 67, 52),
                    ),
                  );
                  Navigator.popUntil(
                      context, ModalRoute.withName('/reservations_page'));
                  return;
                }

                try {
                  await apiProvider.deleteReservation(
                      reservationToken: reservation.reservationToken);
                } on DioError {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("Connection error!"),
                      backgroundColor: Color.fromARGB(255, 227, 67, 52),
                    ),
                  );
                  navigator.popUntil(ModalRoute.withName('/reservations_page'));
                  return;
                }

                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text("Reservation canceled."),
                  ),
                );
                navigator.popUntil(ModalRoute.withName('/reservations_page'));
              },
              child: const Text('Confirm'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go back'),
            ),
          ],
        );
      },
    );
  }
}
