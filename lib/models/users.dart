import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);
}
