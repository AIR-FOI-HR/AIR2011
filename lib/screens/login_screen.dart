import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/login_card.dart';
import '../widgets/signup_card.dart';
import 'package:flutter/material.dart';

enum ScreenType { Login, Signup }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ScreenType currentScreen = ScreenType.Login;

  void switchScreenType() {
    if (currentScreen == ScreenType.Login) {
      setState(() {
        currentScreen = ScreenType.Signup;
      });
    } else {
      setState(() {
        currentScreen = ScreenType.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Text(
                      currentScreen == ScreenType.Login
                          ? 'Login'
                          : 'Registration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  currentScreen == ScreenType.Login
                      ? LoginCard(switchScreenType)
                      : SignupCard(switchScreenType),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
