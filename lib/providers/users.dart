import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  //Hardcoded list of users
  List<AppUser> _users = [
    new AppUser(
        id: '1',
        email: 'iivic@gmail.com',
        name: 'Ivo',
        surname: 'Ivic',
        userType: UserType.Admin),
    new AppUser(
      id: '2',
      email: 'mmarkic@gmail.com',
      name: 'Marko',
      surname: 'Markic',
    ),
    new AppUser(
      id: '3',
      email: 'pperic@gmail.com',
      name: 'Pero',
      surname: 'Peric',
    ),
    new AppUser(
      id: '4',
      email: 'ivivic@gmail.com',
      name: 'Iva',
      surname: 'Ivic',
    ),
    new AppUser(
      id: '5',
      email: 'mmatic@gmail.com',
      name: 'Mate',
      surname: 'Matic',
    ),
    new AppUser(
      id: '6',
      email: 'aanic@gmail.com',
      name: 'Ana',
      surname: 'Anic',
    ),
    new AppUser(
      id: '7',
      email: 'ppetric@gmail.com',
      name: 'Petra',
      surname: 'Petric',
    ),
  ];

  //Getter for users list
  List<AppUser> get allUsers {
    return [..._users];
  }
}
