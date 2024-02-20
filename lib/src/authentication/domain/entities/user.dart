// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? firstName,
      lastName,
      email,
      phoneNumber,
      
      password,
      profileUrl;
  String? uid,id;
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.id,
      required this.uid,
      required this.password,
      required this.profileUrl});

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        id,
        uid,
        profileUrl,
        password,
      ];

  toMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "id": id,
      "uid": uid,
      "password": password,
      "profile_url": profileUrl
    };
  }
}
