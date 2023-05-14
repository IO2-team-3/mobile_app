import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:mobile_app/utility/decode_base64.dart';

class PlaceInfo extends StatelessWidget {
  final Reservation reservation;
  const PlaceInfo({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    ImageProvider placeSchemaImgProvider;
    final placeSchema = reservation.placeSchema;
    if (placeSchema != null && placeSchema.isNotEmpty) {
      try {
        placeSchemaImgProvider = MemoryImage(decodeBase64(placeSchema));
      } catch (e) {
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
      body: Card(
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: InteractiveViewer(
                    minScale: 1.0,
                    maxScale: 5.0,
                    child: Image(
                      image: placeSchemaImgProvider,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
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
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Image.asset('assets/img/layout/interior-theater.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
