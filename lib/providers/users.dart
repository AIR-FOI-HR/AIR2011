import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  //Hardcoded list of users, right now only used
  //for hardcoded orders
  List<AppUser> _users_hardcoded = [
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

  //Getter for hardcoded users list
  List<AppUser> get allUsers_hardcoded {
    return [..._users_hardcoded];
  }

  //List of all users stored in database
  List<AppUser> _users = [];
  List<AppUser> get allUsers {
    return [..._users];
  }

  Future<void> fetchClients() async {
    List<AppUser> loadedUsers = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Clients').get();
    for (var doc in querySnapshot.docs) {
      loadedUsers.add(AppUser(
        id: doc.data()['ClientId'],
        email: doc.data()['Email'],
        name: doc.data()['Name'],
        surname: doc.data()['Surname'],
      ));
    }
    _users = loadedUsers;
    notifyListeners();
  }

  void printUsers() {
    for (var user in _users) {
      print(user.id);
    }
  }
}
