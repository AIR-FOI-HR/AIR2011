import 'dart:async';
import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => tryAutoSignIn(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/logo.png'),
      height: MediaQuery.of(context).size.height,
    );
  }

  void tryAutoSignIn(context) async {
    //bool userSignedIn = await AuthenticationManipulator.isUserLoggedIn();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userEmail') == true) {
      final prefs = await SharedPreferences.getInstance();
      AuthenticationManipulator.loginUser(context, prefs.getString('userEmail'),
          prefs.getString('userPassword'));
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }
}
