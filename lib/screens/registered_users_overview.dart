import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/providers/users.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:air_2011/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import '../screens/view_orders_screen.dart';
import 'package:provider/provider.dart';

class RegisteredUsersOverview extends StatelessWidget {
  static const routeName = 'registered-users';

  Future<void> _fetchUsers(BuildContext context) async {
    await Provider.of<Users>(context, listen: false).fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    setUpNotificationSystem(
        context); //adding notification dialog for currently opened widget

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registered users',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        height: deviceSize.height - 200,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _fetchUsers(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Consumer<Users>(
                          builder: (ctx, userData, _) => ListView.builder(
                            itemBuilder: (_, i) => Column(
                              children: [
                                UserListTile(userData.allUsers[i]),
                                Divider()
                              ],
                            ),
                            itemCount: userData.allUsers.length,
                          ),
                        ),
                      ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
