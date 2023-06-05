import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? description;
  String? username;
  String? password;
  String? profilePicture;

  User() {}
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
