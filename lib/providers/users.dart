import 'package:flutter/material.dart';

import './user.dart';

class Users {
  //Hardcoded list of users
  List<User> _users = [
    new User(
        id: '1',
        email: 'iivic@gmail.com',
        name: 'Ivo',
        surname: 'Ivic',
        userType: UserType.Admin),
    new User(
      id: '2',
      email: 'mmarkic@gmail.com',
      name: 'Marko',
      surname: 'Markic',
    ),
    new User(
      id: '3',
      email: 'pperic@gmail.com',
      name: 'Pero',
      surname: 'Peric',
    ),
    new User(
      id: '4',
      email: 'ivivic@gmail.com',
      name: 'Iva',
      surname: 'Ivic',
    ),
    new User(
      id: '5',
      email: 'mmatic@gmail.com',
      name: 'Mate',
      surname: 'Matic',
    ),
    new User(
      id: '6',
      email: 'aanic@gmail.com',
      name: 'Ana',
      surname: 'Anic',
    ),
    new User(
      id: '7',
      email: 'ppetric@gmail.com',
      name: 'Petra',
      surname: 'Petric',
    ),
  ];

  //Getter for users list
  List<User> get allUsers {
    return [..._users];
  }
}
