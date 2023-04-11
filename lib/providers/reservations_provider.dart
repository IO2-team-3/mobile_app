import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:path_provider/path_provider.dart';

class ReservationsStorageProvider extends ChangeNotifier {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<List<Reservation>> readReservations() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final entities = await appDocDir.list().toList();
    final reservationFiles = entities.whereType<File>();
    List<Reservation> reservations = [];
    for (var file in reservationFiles) {
      final contents = await file.readAsString();
      reservations.add(Reservation.fromJson(jsonDecode(contents)));
    }

    return reservations;
  }

  Future<void> writeReservation(
      int eventId, int placeId, Reservation reservation) async {
    final pathToAppDocDir = await _localPath;
    final reservationFile =
        await File('$pathToAppDocDir/reservations/$eventId-$placeId')
            .create(recursive: true);
    reservationFile.writeAsString(jsonEncode(reservation.toJson()));
  }
}
