// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message()
  ..messageId = json['messageId'] as int?
  ..content = json['content'] as String?
  ..sender = json['sender'] as int?
  ..receiver = json['receiver'] as int?;

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'content': instance.content,
      'sender': instance.sender,
      'receiver': instance.receiver,
    };
