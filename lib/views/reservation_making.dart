import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/providers/reservations_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import '../models/reservation.dart';

class ReservationMaking extends StatefulWidget {
  final int eventId;
  final String address;
  const ReservationMaking({
    super.key,
    required this.eventId,
    required this.address,
  });

  @override
  State<ReservationMaking> createState() => _ReservationMakingState();
}

class _ReservationMakingState extends State<ReservationMaking> {
  int? _selectedPlaceIndex;
  int? _selectedPlaceId;
  late int _eventId;

  @override
  void initState() {
    super.initState();
    _eventId = widget.eventId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make a reservation',
          overflow: TextOverflow.fade,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Response<EventWithPlaces>>(
        future: Provider.of<APIProvider>(context, listen: false)
            .fetchEventById(id: _eventId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Connection error!'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final EventWithPlaces event = snapshot.data!.data!;
          ImageProvider placeSchemaImgProvider;
          final placeSchema = event.placeSchema;
          if (placeSchema != null) {
            try {
              placeSchemaImgProvider = MemoryImage(
                  base64Decode(base64.normalize(event.placeSchema!)));
            } on FormatException {
              placeSchemaImgProvider =
                  Image.asset('assets/img/placeholder.png').image;
            }
          } else {
            placeSchemaImgProvider =
                Image.asset('assets/img/placeholder.png').image;
          }

          final freePlaces = filterFreePlaces(event.places);
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: placeSchemaImgProvider,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: freePlaces.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text('Place ${freePlaces[index].id}'),
                        tileColor:
                            _selectedPlaceIndex == index ? Colors.blue : null,
                        onTap: () {
                          setState(() {
                            if (_selectedPlaceIndex == index) {
                              _selectedPlaceIndex = null;
                              _selectedPlaceId = null;
                            } else {
                              _selectedPlaceIndex = index;
                              _selectedPlaceId = freePlaces[index].id;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Response<ReservationDTO> reservationResponse;
                  try {
                    reservationResponse =
                        await Provider.of<APIProvider>(context, listen: false)
                            .makeReservation(
                      eventId: _eventId,
                      placeId: _selectedPlaceId,
                    );
                  } on DioError catch (e) {
                    final response = e.response;
                    if (response == null) {
                      showConnectionErrorDialog(context);
                      return;
                    }
                    if (response.statusCode == 400) {
                      showPlaceTakenDialog(context);
                    }
                    if (response.statusCode == 404) {
                      showDoesNotExistDialog(context);
                    }
                    return;
                  }
                  if (!mounted) return;

                  final reservationDTO = reservationResponse.data!;
                  final reservation = Reservation(
                    eventId: event.id,
                    title: event.title,
                    startTime: event.startTime,
                    endTime: event.endTime,
                    address: widget.address,
                    name: event.name,
                    reservationToken: reservationDTO.reservationToken,
                    placeId: reservationDTO.placeId,
                    placeSchema: event.placeSchema,
                  );
                  Provider.of<ReservationsStorageProvider>(context,
                          listen: false)
                      .writeReservation(
                          event.id, reservationDTO.placeId, reservation);

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reservation made!'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  _selectedPlaceId == null
                      ? 'RESERVE ANY PLACE'
                      : 'RESERVE THIS PLACE',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> showConnectionErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Connection error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showPlaceTakenDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Place taken'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showDoesNotExistDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event does not exist'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<EventsCacheProvider>(context, listen: false)
                    .refreshAllEvents(false);
                Navigator.popUntil(
                    context, ModalRoute.withName('/events_page'));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

List<Place> filterFreePlaces(BuiltList<Place>? allPlaces) {
  if (allPlaces == null) {
    return [];
  }
  return allPlaces
      .asList()
      .where((place) => place.free == true)
      .sortedBy<num>((element) => element.id);
}
