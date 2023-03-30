import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider extends ChangeNotifier {
  Future<List<Location>> getLocationsFromAddress(String address) async {
    return locationFromAddress(address);
  }
}
