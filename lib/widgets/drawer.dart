import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/interface_scheme/authentication_scheme.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/client-screens/view_orders_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

class AppDrawer extends StatelessWidget {
  //bool isAdmin = false;
  bool built = false;
  IAuthenticate _auth = new AuthenticationManipulator();
  @override
  Widget build(BuildContext context) {
    String _tmpId = "";
    if (FirebaseAuth.instance.currentUser != null) {
      _tmpId = FirebaseAuth.instance.currentUser.uid;
    }
    final String _loggedUserUid = _tmpId;
    final AppUser _loggedUser =
        Provider.of<Users>(context).getAdminById(_loggedUserUid);

    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('View all orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(_loggedUser != null
                  ? ViewOrdersScreen.routeName
                  : ViewOrdersScreenClient.routeName);
            },
          ),
          Divider(),
          if (_loggedUser != null)
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Registered users'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RegisteredUsersOverview.routeName);
              },
            ),
          if (_loggedUser != null) Divider(),
          if (_loggedUser != null)
            ListTile(
              leading: Icon(
                Icons.post_add_outlined,
                color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Log Out'),
            onTap: () {
              _auth.signOutUser(context);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
