import 'package:air_2011/providers/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseManipulator with ChangeNotifier{
  static void createUser(AppUser client){
      CollectionReference clients = FirebaseFirestore.instance.collection('Clients');
      clients.doc(client.id).set({
        'ClientId': client.id,
        'Name': client.name,
        'Surname' : client.surname,
        'Email' : client.email
       }).then((value) => print("User has been added"));

  }
}