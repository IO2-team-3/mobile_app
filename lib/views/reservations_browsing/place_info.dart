import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';

class PlaceInfo extends StatelessWidget {
  final Reservation reservation;
  const PlaceInfo({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    ImageProvider placeSchemaImgProvider;
    final placeSchema = reservation.placeSchema;
    if (placeSchema != null) {
      try {
        placeSchemaImgProvider = MemoryImage(
          base64Decode(
            base64.normalize(placeSchema),
          ),
        );
      } on FormatException {
        placeSchemaImgProvider =
            Image.asset('assets/img/placeholder.png').image;
      }
    } else {
      placeSchemaImgProvider = Image.asset('assets/img/placeholder.png').image;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place info'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 5.0,
              child:
                  Image(image: placeSchemaImgProvider, fit: BoxFit.fitHeight),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Your place:',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20.0,
            ),
          ),
          Text(
            'Place ${reservation.placeId}',
          ),
        ],
      ),
    );
  }
}
