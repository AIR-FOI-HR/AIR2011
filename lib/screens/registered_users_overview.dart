import 'package:flutter/material.dart';
import '../screens/view_orders_screen.dart';

class RegisteredUsersOverview extends StatelessWidget {
  static const routeName = 'registered-users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO add/edit registered users screen implementation'),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ViewOrdersScreen.routeName);
            },
            child: Text('return'),
          )
        ],
      ),
    );
  }
}
