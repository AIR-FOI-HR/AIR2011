import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GKMApp',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: LoginScreen(),
      routes: {
        ViewOrdersScreen.routeName: (ctx) => ViewOrdersScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}
