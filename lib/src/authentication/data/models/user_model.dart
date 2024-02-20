// ignore_for_file: must_be_immutable

import 'package:house_rental/src/authentication/domain/entities/user.dart';

class UserModel extends User {
   UserModel(
      {required super.firstName,
      required super.lastName,
      required super.email,
      required super.phoneNumber,
      required super.id,
      required super.uid,
      required super.password,
      required super.profileUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      id: json["id"],
      uid: json["uid"],
      password: json["password"],
      profileUrl:json["profile_url"]);

  @override
  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "id": id,
        "uid": uid,
        "password": password,
        "profile_url":profileUrl
      };
}
