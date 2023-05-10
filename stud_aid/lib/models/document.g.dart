// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document()
  ..documentId = json['documentId'] as int?
  ..documentName = json['documentName'] as String?
  ..author = json['author'] as String?
  ..description = json['description'] as String?;

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'documentName': instance.documentName,
      'author': instance.author,
      'description': instance.description,
    };
