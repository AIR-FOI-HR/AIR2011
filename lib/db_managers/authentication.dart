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
  Future<void> signUpUser(context, email, name, surname, password) async {
    print("Im here!");
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
        print(userCredential);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogShower.showDialogBox('Password too weak',
            'Please enter stronger password', context, null);
      } else if (e.code == 'email-already-in-use') {
        DialogShower.showDialogBox(
            'E-Mail already in use',
            'This E-Mail is already in use. Please try another E-Mail address',
            context,
            null);
      }
    }
  }

  Future<void> signOutUser(context) async {
    //unlinking fcm token from user
    final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
    DatabaseManipulator.removeTokenFromUser(_loggedUserUid);

    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    await FirebaseAuth.instance.signOut();

    //deleting user info from phone
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> forgotPassword(context, email) async {
    //unlinking fcm token from user
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        DialogShower.showDialogBox(
            'Reset password E-Mail sent',
            'Please check your E-Mail inbox to reset your password',
            context,
            LoginScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      DialogShower.showDialogBox('This E-Mail does not exist',
          'Please enter existing E-Mail address', context, null);
    }
  }

  Future<void> loginUser(context, email, password) async {
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

        //linking fcm token to logged in user
        final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
        DatabaseManipulator.addTokenToUser(_loggedUserUid);

        //saving user info on phone after successfull login
        final prefrences = await SharedPreferences.getInstance();
        prefrences.setString('userEmail', email);
        prefrences.setString('userPassword', password);
      }
    } on FirebaseAuthException catch (e) {
      DialogShower.showDialogBox('Wrong E-Mail or Password',
          'Please enter valid E-Mail or password', context, null);
    }
  }
}
