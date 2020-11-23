import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  //Temporary user instance, later will use logged in user data
  final AppUser tempVarUser;

  CustomAppbar(this._scaffoldKey, this.tempVarUser);

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
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            }),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          child: Text(
            "${tempVarUser.name[0]}${tempVarUser.surname[0]}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
