import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // map => model
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  // model => map
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
