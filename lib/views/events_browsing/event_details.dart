import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/views/reservation_making.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import '../common/place_information.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var startDate = DateTime.fromMillisecondsSinceEpoch(event.startTime * 1000);
    var endDate = DateTime.fromMillisecondsSinceEpoch(event.endTime * 1000);

    var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
    var startDateStrHM = DateFormat.jm().format(startDate);
    var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
    var endDateStrHM = DateFormat.jm().format(endDate);

    var latitude = double.parse(event.latitude);
    var longitude = double.parse(event.longitude);
    bool addressNotFound = false;
    String address = '(${event.latitude}, ${event.longitude})';

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReservationMaking(
                eventId: event.id,
                address: address,
              ),
            ),
          );
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
                event.name,
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
            future: placemarkFromCoordinatesSafe(latitude, longitude),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                addressNotFound = true;
              }
              if (!snapshot.hasData && !snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (addressNotFound || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: PlaceInformation(
                    addressWidget:
                        Text('(${event.longitude}, ${event.latitude})'),
                  ),
                );
              } else {
                Placemark placemark = snapshot.data![0];
                address = getAddressString(placemark);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: PlaceInformation(
                    addressWidget: PlacemarkInfo(placemark: placemark),
                  ),
                );
              }
            },
          ),
          FutureBuilder<Response<BuiltList<String>>>(
            future: context.read<APIProvider>().listPhotosForEvent(
                  eventId: event.id,
                ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var photos = snapshot.data!.data!;
              debugPrint('itemCount = ${photos.length}');
              return Expanded(
                child: ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (_, index) => Image.network(photos[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<Placemark>> placemarkFromCoordinatesSafe(
      double latitude, double longitude) async {
    final List<Placemark> placemarks;
    try {
      placemarks = await placemarkFromCoordinates(latitude, longitude);
    } on PlatformException {
      return [];
    }
    return placemarks;
  }
}

String getAddressString(Placemark placemark) {
  String? street = placemark.street;
  String? country = placemark.country;
  String? locality = placemark.locality;
  String? administrativeArea = placemark.administrativeArea;

  final buffer = StringBuffer();
  buffer.write(street ?? 'unknown street');
  buffer.write('\n');
  buffer.write(locality ?? 'unknown locality');
  buffer.write(', ');
  buffer.write(administrativeArea ?? 'unknown administrative area');
  buffer.write('\n');
  buffer.write(country ?? 'unknown country');
  return buffer.toString();
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
        Text(street ?? 'unknown street'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locality ?? 'unknown locality'),
            const SizedBox(
              width: 5,
            ),
            Text(administrativeArea ?? 'unknown administrative area'),
          ],
        ),
        Text(country ?? 'unknown country'),
      ],
    );
  }
}
