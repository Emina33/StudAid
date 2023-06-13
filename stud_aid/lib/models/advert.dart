import 'package:json_annotation/json_annotation.dart';

part 'advert.g.dart';

@JsonSerializable()
class Advert {
  int? advertId;
  String? advertName;
  double? price;
  String? availableTime;
  int? tutor;
  int? subjectId;

  Advert() {}
  factory Advert.fromJson(Map<String, dynamic> json) => _$AdvertFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertToJson(this);
}
