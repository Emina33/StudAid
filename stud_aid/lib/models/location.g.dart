// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location()
  ..locationId = json['locationId'] as int?
  ..city = json['city'] as String?
  ..country = json['country'] as String?;

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'locationId': instance.locationId,
      'city': instance.city,
      'country': instance.country,
    };
