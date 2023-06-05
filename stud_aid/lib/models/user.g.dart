// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['userId'] as int?
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..description = json['description'] as String?
  ..username = json['username'] as String?
  ..password = json['password'] as String?
  ..profilePicture = json['profilePicture'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'description': instance.description,
      'username': instance.username,
      'password': instance.password,
      'profilePicture': instance.profilePicture,
    };
