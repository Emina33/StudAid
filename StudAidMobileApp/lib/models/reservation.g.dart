// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) => Reservation()
  ..reservationId = json['reservationId'] as int?
  ..advertId = json['advertId'] as int?
  ..userId = json['userId'] as int?
  ..selectedTime = json['selectedTime'] as String?;

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'reservationId': instance.reservationId,
      'advertId': instance.advertId,
      'userId': instance.userId,
      'selectedTime': instance.selectedTime,
    };
