import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var startDate =
        DateTime.fromMillisecondsSinceEpoch(event.startTime! * 1000);
    var endDate = DateTime.fromMillisecondsSinceEpoch(event.endTime! * 1000);

    var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
    var startDateStrHM = DateFormat.jm().format(startDate);
    var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
    var endDateStrHM = DateFormat.jm().format(endDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Reserve'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                event.name!,
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
        ],
      ),
    );
  }
}
