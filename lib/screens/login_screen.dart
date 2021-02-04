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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  /*Function for switching between Login screen
    and Signup/Registration screen
  */
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
              color: Colors.white,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    child: Image.asset(
                      'assets/logo.png',
                      filterQuality: FilterQuality.high,
                    ),
                    height: currentScreen == ScreenType.Login ? 230.0 : 150.0,
                    duration: Duration(milliseconds: 100),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 2),
                    child: currentScreen == ScreenType.Login
                        ? LoginCard(switchScreenType, _formKey)
                        : SignupCard(switchScreenType, _formKey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
