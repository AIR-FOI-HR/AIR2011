import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AuthenticationManipulator{

  static Future<void> signUpUser(context, email, password, name, surname) async {
    try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email,
                password: password);
        if(userCredential != null)
        {
          //Create in database user data
          print(userCredential);

        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      }on PlatformException catch(e){
        print("Invalid login attemtp!");
        print(e);
      }
      catch (e) {
        print(e);
      }

  }
  static Future<void> loginUser(context, email, password)
  async {
    try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.trim(), password: password);
        if (userCredential != null) {
          print(userCredential);
          Navigator.of(context)
              .pushReplacementNamed(ViewOrdersScreen.routeName);
        }
      } on PlatformException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        print(e);
      }
  }
}