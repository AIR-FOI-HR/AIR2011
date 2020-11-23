import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: Theme.of(context).accentColor,
            ),
            title: Text('View all orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ViewOrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Registered users'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RegisteredUsersOverview.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.post_add_outlined,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Add new order'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddOrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Log Out'),
            onTap: () {
              AuthenticationManipulator.signOutUser(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
