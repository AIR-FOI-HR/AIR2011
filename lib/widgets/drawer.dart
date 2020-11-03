import 'package:air_2011/screens/add_edit_order_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String _loggedUserName;

  AppDrawer(this._loggedUserName);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${_loggedUserName}'),
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
                  .pushReplacementNamed(AddEditOrderScreen.routeName);
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
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
