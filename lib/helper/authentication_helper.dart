import 'package:air_2011/helper/dialog_shower.dart';
import 'package:air_2011/screens/client-screens/view_orders_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationHelper {
  static void redirectSignOut(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  static void loginHandler(context, String response) {
    switch (response) {
      case 'admin':
        Navigator.of(context).pushReplacementNamed(ViewOrdersScreen.routeName);
        break;
      case 'client':
        Navigator.of(context)
            .pushReplacementNamed(ViewOrdersScreenClient.routeName);
        break;
      case 'nonUser':
        DialogShower.showDialogBox(
            'User does not exist', 'User does not exist', context, null);
        break;
      default:
        DialogShower.showDialogBox(
            'Error while signing in', response, context, null);
        break;
    }
  }

  static void forgottenPasswordHandler(context, bool exists) {
    if (exists) {
      DialogShower.showDialogBox(
          'Reset password E-Mail sent',
          'Please check your E-Mail inbox to reset your password',
          context,
          LoginScreen.routeName);
    } else {
      DialogShower.showDialogBox('This E-Mail does not exist',
          'Please enter existing E-Mail address', context, null);
    }
  }

  static void signUpHandler(context, String response) {
    switch (response) {
      case 'success':
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        break;
      case 'notSuccessful':
        DialogShower.showDialogBox(
            'Sign Up not successful',
            'We were not able to sign you up. Please try again.',
            context,
            null);
        break;
      default:
        if (response == 'weak-password') {
          DialogShower.showDialogBox('Password too weak',
              'Please enter stronger password', context, null);
        } else if (response == 'email-already-in-use') {
          DialogShower.showDialogBox(
              'E-Mail already in use',
              'This E-Mail is already in use. Please try another E-Mail address',
              context,
              null);
        }
        break;
    }
  }
}
