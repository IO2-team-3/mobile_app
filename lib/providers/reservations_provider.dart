import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/models/reservation.dart';
import 'package:path_provider/path_provider.dart';

class ReservationsStorageProvider extends ChangeNotifier {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return '${directory.path}/reservations';
  }

  Future<List<Reservation>> readReservations() async {
    final resDirPath = await _localPath;
    final resDir = Directory(resDirPath);
    final List<FileSystemEntity> entities;
    try {
      entities = await resDir.list().toList();
    } on PathNotFoundException {
      return [];
    }
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
    final pathToResDir = await _localPath;
    final reservationFile =
        await File('$pathToResDir/$eventId-$placeId').create(recursive: true);
    reservationFile.writeAsString(jsonEncode(reservation.toJson()));
  }

  Future<void> removeReservation(int eventId, int placeId) async {
    final pathToResDir = await _localPath;
    final reservationFile = File('$pathToResDir/$eventId-$placeId');
    await reservationFile.delete();
    notifyListeners();
  }
}
