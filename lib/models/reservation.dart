import 'package:json_annotation/json_annotation.dart';
part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  int eventId;
  String title;
  int startTime;
  int endTime;
  String address;
  String name;
  String? placeSchema;
  String reservationToken;
  int placeId;

  Reservation({
    required this.eventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.name,
    this.placeSchema,
    required this.reservationToken,
    required this.placeId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
