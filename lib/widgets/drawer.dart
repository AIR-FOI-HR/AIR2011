import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/registered_users_overview.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

class AppDrawer extends StatelessWidget {
  final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
  //bool isAdmin = false;
  int timesBuilt = 0;
  @override
  Widget build(BuildContext context) {
    timesBuilt += 1;
    print(timesBuilt);
    AppUser _loggedUser =
        Provider.of<Users>(context).getAdminById(_loggedUserUid);

    /*CollectionReference users =
        FirebaseFirestore.instance.collection('Administrator');
    users.doc(_loggedUserUid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        isAdmin = true;
      }
    });*/

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
          if (_loggedUser != null)
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
          if (_loggedUser != null) Divider(),
          if (_loggedUser != null)
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
