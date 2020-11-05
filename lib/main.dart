import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/order_detail_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
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
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      home: LoginScreen(),
      routes: {
        ViewOrdersScreen.routeName: (ctx) => ViewOrdersScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        AddOrderScreen.routeName: (ctx) => AddOrderScreen(),
        RegisteredUsersOverview.routeName: (ctx) => RegisteredUsersOverview(),
        OrderDetailScreen.routeName: (ctx) => OrderDetailScreen(),
      },
    );
  }
}
