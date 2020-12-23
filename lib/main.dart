import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:air_2011/screens/single_order_screen.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/users.dart';
import './providers/orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Users(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationManipulator(),
        ),
      ],
      child: MaterialApp(
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
          SingleOrderScreen.routeName: (ctx) => SingleOrderScreen()
        },
      ),
    );
  }
}
