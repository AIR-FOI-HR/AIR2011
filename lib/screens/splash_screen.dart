import 'dart:async';
import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/helper/authentication_helper.dart';
import 'package:air_2011/interface_scheme/authentication_scheme.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  IAuthenticate _auth = new AuthenticationManipulator();
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
      String loginResponse = await _auth.loginUser(
          prefs.getString('userEmail'), prefs.getString('userPassword'));
      AuthenticationHelper.loginHandler(context, loginResponse);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }
}
