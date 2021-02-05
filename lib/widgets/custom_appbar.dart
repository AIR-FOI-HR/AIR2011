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

  CustomAppbar(this._scaffoldKey);
  bool built = false;
  @override
  Widget build(BuildContext context) {
    Future<void> _getUsers() async {
      if (!built) {
        await Provider.of<Users>(context, listen: false).fetchClients();
        await Provider.of<Users>(context, listen: false).fetchAdministrator();
        built = true;
      }
    }

    //final userData = Provider.of<Users>(context, listen: false);
    final String _loggedUserUid = FirebaseAuth.instance.currentUser.uid;
    //final AppUser _user = userData.getUserById(_loggedUserUid);
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
        Tab(
          icon: Image.asset('assets/logo.png'),
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          child: FutureBuilder(
            future: _getUsers(),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Consumer<Users>(
                          builder: (ctx, userData, _) => Text(
                            "${userData.getUserById(_loggedUserUid).name[0]}${userData.getUserById(_loggedUserUid).surname[0]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
          ),
          /*Text(
            "${_user.name[0]}${_user.surname[0]}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),*/
        ),
      ]),
    );
  }
}
