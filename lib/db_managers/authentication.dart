import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthenticationManipulator with ChangeNotifier {
  static Future<void> signUpUser(
      context, email, password, name, surname) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        //Create in database user data
        print(userCredential);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }
  static Future<void>signOutUser(context) async{
    await FirebaseAuth.instance.signOut();
     Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

  }

  static Future<void> loginUser(context, email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (userCredential != null) {
        print(userCredential.user.uid);
        if(isUserAdmin(userCredential.user.uid)){
           Navigator.of(context).pushReplacementNamed(ViewOrdersScreen.routeName);
        }
        //
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static bool isUserAdmin(uid){
        bool isAdmin = false;
        CollectionReference users = FirebaseFirestore.instance.collection('Administrators');
        users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
            print('User is administrator.');
            isAdmin = true;
          }
        });
        return isAdmin;

  }
}
