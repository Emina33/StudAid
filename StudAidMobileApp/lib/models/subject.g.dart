// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject()
  ..subjectId = json['subjectId'] as int?
  ..subjectName = json['subjectName'] as String?
  ..categoryId = json['categoryId'] as int?;

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'categoryId': instance.categoryId,
    };
