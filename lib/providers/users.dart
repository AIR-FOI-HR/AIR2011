import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  //List of all users stored in database
  List<AppUser> _users = [];
  List<AppUser> _admins = [];
  List<AppUser> get allUsers {
    return [..._users];
  }

  List<AppUser> get allAdmins {
    return [..._admins];
  }

  Future<void> fetchClients() async {
    List<AppUser> loadedUsers = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Clients').get();
    for (var doc in querySnapshot.docs) {
      var _fcmToken = doc.data()['FcmToken'];
      if (_fcmToken != null) {
        loadedUsers.add(AppUser(
            id: doc.data()['ClientId'],
            email: doc.data()['Email'],
            name: doc.data()['Name'],
            surname: doc.data()['Surname'],
            fcmToken: _fcmToken));
      } else {
        loadedUsers.add(AppUser(
          id: doc.data()['ClientId'],
          email: doc.data()['Email'],
          name: doc.data()['Name'],
          surname: doc.data()['Surname'],
        ));
      }
    }
    _users = loadedUsers;
    notifyListeners();
  }

  Future<void> fetchAdministrator() async {
    List<AppUser> loadedUsers = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Administrator').get();
    for (var doc in querySnapshot.docs) {
      loadedUsers.add(AppUser(
        id: doc.id,
        email: doc.data()['Email'],
        name: doc.data()['Name'],
        surname: doc.data()['Surname'],
      ));
    }
    _admins = loadedUsers;
    notifyListeners();
  }

  AppUser getUserById(String id) {
    //getting hardcoded users for now
    return _users.firstWhere((user) => user.id == id);
  }

  AppUser getAdminById(String id) {
    //getting hardcoded users for now

    return _admins.firstWhere((user) => user.id == id, orElse: () => null);
  }
}
