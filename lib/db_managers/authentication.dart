import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/helper/dialog_shower.dart';
import 'package:air_2011/interface_scheme/authentication_scheme.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/client-screens/view_orders_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notifications.dart';

class AuthenticationManipulator implements IAuthenticate {
  @override
  Future<String> signUpUser(email, name, surname, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      if (userCredential != null) {
        String fcmToken = await returnCurrentFcmToken();
        AppUser appUserSignup = new AppUser(
            id: userCredential.user.uid,
            email: email,
            name: name,
            surname: surname,
            fcmToken: fcmToken);

        DatabaseManipulator.createUser(appUserSignup);
        //continue with login
        return 'success';
      } else {
        return 'notSuccessful';
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> signOutUser() async {
    //unlinking fcm token from user
    final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
    DatabaseManipulator.removeTokenFromUser(_loggedUserUid);
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> forgotPassword(email) async {
    //unlinking fcm token from user
    try {
      return await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return true;
      });
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  Future<String> loginUser(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (userCredential != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Administrator');

        return users
            .doc(userCredential.user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          //linking fcm token to logged in user
          final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
          DatabaseManipulator.addTokenToUser(_loggedUserUid);

          //saving user info on phone after successfull login
          final prefrences = await SharedPreferences.getInstance();
          prefrences.setString('userEmail', email);
          prefrences.setString('userPassword', password);

          if (documentSnapshot.exists) {
            return 'admin';
          } else {
            return 'client';
          }
        });
      } else {
        return 'nonUser';
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
