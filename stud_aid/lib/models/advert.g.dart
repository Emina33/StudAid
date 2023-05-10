// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advert _$AdvertFromJson(Map<String, dynamic> json) => Advert()
  ..advertId = json['advertId'] as int?
  ..advertName = json['advertName'] as String?
  ..price = (json['price'] as num?)?.toDouble()
  ..availableTime = json['availableTime'] as String?
  ..tutor = json['tutor'] as int?;

Map<String, dynamic> _$AdvertToJson(Advert instance) => <String, dynamic>{
      'advertId': instance.advertId,
      'advertName': instance.advertName,
      'price': instance.price,
      'availableTime': instance.availableTime,
      'tutor': instance.tutor,
    };
