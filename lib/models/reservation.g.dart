// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation(
      eventId: json['eventId'] as int,
      title: json['title'] as String,
      startTime: json['startTime'] as int,
      endTime: json['endTime'] as int,
      address: json['address'] as String,
      name: json['name'] as String,
      placeSchema: json['placeSchema'] as String?,
      reservationToken: json['reservationToken'] as String,
      placeId: json['placeId'] as int,
    );

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'title': instance.title,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'address': instance.address,
      'name': instance.name,
      'placeSchema': instance.placeSchema,
      'reservationToken': instance.reservationToken,
      'placeId': instance.placeId,
    };
