import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  //Temporary user instance, later will use logged in user data

  CustomAppbar(this._scaffoldKey);
  static AppUser _loggedUser = null;
  CollectionReference users =
      FirebaseFirestore.instance.collection('Administrator');

  @override
  Widget build(BuildContext context) {
    //   FirebaseFirestore.instance
    // .collection('Clients')
    // .doc("GJU8UuGwqgbJ5WqqEEuJ0aGxSio1")
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('GJU8UuGwqgbJ5WqqEEuJ0aGxSio1' == FirebaseAuth.instance.currentUser.uid);
    //   }
    // });
    // FirebaseFirestore.instance
    // .collection('Administrator')
    // .doc(FirebaseAuth.instance.currentUser.uid)
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     _loggedUser.id = FirebaseAuth.instance.currentUser.uid;
    //     _loggedUser.name = documentSnapshot["Name"];
    //     _loggedUser.surname = documentSnapshot["Surname"];
    //   }else{
    //     print(FirebaseAuth.instance.currentUser.uid);
    //   }
    // });
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data.data();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      }),
                  IconButton(
                      icon: Icon(Icons.logout),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        AuthenticationManipulator.signOutUser(context);
                      }),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    child: Text(
                      //'${data['Name'][0]}${data['Surname'][0]}',
                      //Temporary solution to clients not be able to log in
                      '', style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
          );
        }

        return Text("loading");
      },
    );
  }
}
