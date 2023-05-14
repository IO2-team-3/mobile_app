import 'package:flutter/material.dart';

class PlaceInformation extends StatelessWidget {
  const PlaceInformation({
    super.key,
    required this.addressWidget,
  });

  final Widget addressWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(
          Icons.place_outlined,
          size: 50.0,
          color: Color.fromARGB(255, 22, 180, 207),
        ),
        addressWidget,
      ],
    );
  }
}
