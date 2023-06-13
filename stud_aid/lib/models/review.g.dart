// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review()
  ..reviewId = json['reviewId'] as int?
  ..reviewText = json['reviewText'] as String?
  ..reviewStars = json['reviewStars'] as int?
  ..reviewer = json['reviewer'] as int?;

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'reviewId': instance.reviewId,
      'reviewText': instance.reviewText,
      'reviewStars': instance.reviewStars,
      'reviewer': instance.reviewer,
    };
