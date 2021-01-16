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
    //Timer(Duration(seconds: 3), () => MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }

  void tryAutoSignIn(context) async {
    bool userSignedIn = await AuthenticationManipulator.isUserLoggedIn();
    if (userSignedIn) {
      final prefs = await SharedPreferences.getInstance();
      //_email = prefs.getString('userEmail');
      //_password = prefs.getString('userPassword');
      AuthenticationManipulator.loginUser(context, prefs.getString('userEmail'),
          prefs.getString('userPassword'));
    } else {
      //MaterialPageRoute(builder: (context) => LoginScreen());
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }
}
