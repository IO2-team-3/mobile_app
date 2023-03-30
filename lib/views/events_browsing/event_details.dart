import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

    var latitude = double.parse(event.latitude!);
    var longitude = double.parse(event.longitude!);
    bool addressNotFound = false;

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
          FutureBuilder<List<Placemark>>(
            future: placemarkFromCoordinates(latitude, longitude),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                addressNotFound = true;
              }
              if (!snapshot.hasData && !snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Placemark placemark;
              if (addressNotFound) {
                placemark = Placemark();
              } else {
                placemark = snapshot.data![0];
              }
              return PlacemarkInfo(placemark: placemark);
            },
          ),
        ],
      ),
    );
  }
}

class PlacemarkInfo extends StatelessWidget {
  final Placemark placemark;
  const PlacemarkInfo({super.key, required this.placemark});

  @override
  Widget build(BuildContext context) {
    String? street = placemark.street;
    String? country = placemark.country;
    String? locality = placemark.locality;
    String? administrativeArea = placemark.administrativeArea;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(street ?? '?unknown street?'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locality ?? '?unknown locality?'),
            const SizedBox(
              width: 5,
            ),
            Text(administrativeArea ?? '?unknown administrative area?'),
          ],
        ),
        Text(country ?? '?unknown country?'),
      ],
    );
  }
}
