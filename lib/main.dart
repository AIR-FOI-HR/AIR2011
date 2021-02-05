import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/client-screens/order_preview.dart';
import 'package:air_2011/screens/client-screens/view_orders_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:air_2011/screens/single_order_screen.dart';
import 'package:air_2011/screens/splash_screen.dart';
import 'package:air_2011/screens/user_order_list.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/users.dart';
import './providers/orders.dart';
import 'package:page_transition/page_transition.dart';

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
          primaryColor: Colors.black,
          accentColor: Colors.deepOrangeAccent,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
              button: TextStyle(
                fontSize: 16,
              ),
              subtitle2: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              caption: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        home: SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'orders-screen':
              return PageTransition(
                  child: ViewOrdersScreen(),
                  type: PageTransitionType.bottomToTop);
              break;
            case '/login':
              return PageTransition(
                  child: LoginScreen(), type: PageTransitionType.topToBottom);
              break;
            case 'orders-screen-client':
              return PageTransition(
                  child: ViewOrdersScreenClient(),
                  type: PageTransitionType.bottomToTop);
              break;
            case 'single-order-client':
              return PageTransition(
                  child: SingleOrderClientScreen(),
                  type: PageTransitionType.leftToRight,
                  settings: settings);
              break;
            case 'add-order':
              return PageTransition(
                  child: AddOrderScreen(),
                  type: PageTransitionType.rightToLeft);
              break;
            case 'registered-users':
              return PageTransition(
                  child: RegisteredUsersOverview(),
                  type: PageTransitionType.leftToRight);
              break;
            case 'user-order-list':
              return PageTransition(
                  child: UserOrderList(),
                  type: PageTransitionType.leftToRight,
                  settings: settings);
              break;
            case 'single-order':
              return PageTransition(
                  child: SingleOrderScreen(),
                  type: PageTransitionType.leftToRight,
                  settings: settings);
              break;
            default:
              return null;
          }
        },
      ),
    );
  }
}
