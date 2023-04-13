import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/views/reservations_browsing/place_info.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                builder: (context) => PlaceInfo(
                  reservation: reservation,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO implement anceling a reservation
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => ReservationCanceling(
          //       eventId: event.id,
          //       address: address,
          //     ),
          //   ),
          // );
        },
        label: const Text('Cancel reservation'),
        icon: const Icon(Icons.cancel_outlined),
        backgroundColor: const Color.fromARGB(255, 227, 67, 52),
      ),
      body: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.place_outlined,
                size: 50.0,
                color: Color.fromARGB(255, 22, 180, 207),
              ),
              Text(
                reservation.address,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
