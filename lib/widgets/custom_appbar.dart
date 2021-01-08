import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

class CustomAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  //Temporary user instance, later will use logged in user data

  CustomAppbar(this._scaffoldKey);
  String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;

  String _getUserInitials(context) {
    AppUser _user =
        Provider.of<Users>(context, listen: false).getUserById(_loggedUserUid);
    return "${_user.name[0]}${_user.surname[0]}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        IconButton(
            icon: Icon(Icons.logout),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              AuthenticationManipulator.signOutUser(context);
            }),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          child: Text(
            '${_getUserInitials(context)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
