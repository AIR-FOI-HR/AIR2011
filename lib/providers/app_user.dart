import 'dart:developer';

import 'package:flutter/material.dart';

enum UserType { Admin, Buyer }

class AppUser {
  final String id;
  final String name;
  final String surname;
  final String email;
  final UserType userType;

  AppUser({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.surname,
    this.userType = UserType.Buyer,
  });
}
