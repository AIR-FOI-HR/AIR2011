import 'package:flutter/material.dart';

import '../providers/app_user.dart';

class UserListTile extends StatelessWidget {
  final AppUser _thisUser;

  UserListTile(this._thisUser);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${_thisUser.name} ${_thisUser.surname}'),
      subtitle: Text(_thisUser.email),
      trailing: Icon(
        _thisUser.userType == UserType.Admin
            ? Icons.admin_panel_settings
            : Icons.person,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {},
    );
  }
}
