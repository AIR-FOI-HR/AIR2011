import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/client-screens/view_orders_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/users.dart';

class AuthenticationManipulator with ChangeNotifier {
  static Future<void> signUpUser(
      context, email, name, surname, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      if (userCredential != null) {
        //Create in database user data
        AppUser appUserSignup = new AppUser(
            id: userCredential.user.uid,
            email: email,
            name: name,
            surname: surname);
        DatabaseManipulator.createUser(appUserSignup);
        //continue with login
        print(userCredential);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  static Future<void> signOutUser(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

    //deleting user info from phone
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> loginUser(context, email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (userCredential != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Administrator');
        users
            .doc(userCredential.user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Navigator.of(context)
                .pushReplacementNamed(ViewOrdersScreen.routeName);
          } else {
            Navigator.of(context)
                .pushReplacementNamed(ViewOrdersScreenClient.routeName);
          }
        });

        //saving user info on phone after successfull login
        final prefrences = await SharedPreferences.getInstance();
        prefrences.setString('userEmail', email);
        prefrences.setString('userPassword', password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userEmail') == true) {
      return true;
    }
    return false;
  }
}
