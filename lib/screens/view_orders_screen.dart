import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ViewOrdersScreen extends StatelessWidget {
  static const routeName = 'orders-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              })
        ],
      ),
    );
  }
}
