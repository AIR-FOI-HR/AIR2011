import 'package:air_2011/widgets/forgotten_password_card.dart';
import 'package:air_2011/widgets/login_card.dart';
import '../widgets/signup_card.dart';
import 'package:flutter/material.dart';

enum ScreenType { Login, Signup, Forgotten }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ScreenType currentScreen = ScreenType.Login;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget checkCurrentScreen() {
    if (currentScreen == ScreenType.Login)
      return LoginCard(switchScreenType, _formKey);
    else if (currentScreen == ScreenType.Signup)
      return SignupCard(switchScreenType, _formKey);
    else
      return ForgottenCard(switchScreenType, _formKey);
  }

  /*Function for switching between Login screen
    and Signup/Registration screen
  */
  void switchScreenType(String nameOfScreen) {
    if (nameOfScreen == "Login") {
      setState(() {
        currentScreen = ScreenType.Login;
      });
    } else if (nameOfScreen == "Registration") {
      setState(() {
        currentScreen = ScreenType.Signup;
      });
    } else {
      setState(() {
        currentScreen = ScreenType.Forgotten;
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
                    height: currentScreen == ScreenType.Login ||
                            currentScreen == ScreenType.Forgotten
                        ? 230.0
                        : 150.0,
                    duration: Duration(milliseconds: 100),
                  ),
                  Container(
                    child: checkCurrentScreen(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
