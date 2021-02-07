import 'package:flutter/material.dart';

enum UserType { Admin, Buyer }

class AppUser {
  String id;
  String name;
  String surname;
  String email;
  UserType userType;
  String fcmToken;

  AppUser({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.surname,
    this.fcmToken,
    this.userType = UserType.Buyer,
  });
}
