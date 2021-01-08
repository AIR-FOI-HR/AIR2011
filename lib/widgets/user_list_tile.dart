import 'package:flutter/material.dart';

import '../providers/app_user.dart';

class UserListTile extends StatelessWidget {
  final AppUser _thisUser;
  bool filterBuild = false;
  Function saveBuyer;
  BuildContext ctx;
  UserListTile(this._thisUser);
  UserListTile.fromFilter(
    this._thisUser,
    this.filterBuild,
    this.ctx,
    this.saveBuyer,
  );
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
      onTap: () {
        if (filterBuild) {
          saveBuyer(_thisUser);
          Navigator.pop(ctx);
        }
      },
    );
  }
}
