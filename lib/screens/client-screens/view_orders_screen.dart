import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/client-screens/client_order_tile.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/orders.dart';
import '../../widgets/drawer.dart';
import '../../providers/users.dart';

class ViewOrdersScreenClient extends StatefulWidget {
  static const routeName = 'orders-screen-client';

  @override
  _ViewOrdersScreenClient createState() => _ViewOrdersScreenClient();
}

class _ViewOrdersScreenClient extends State<ViewOrdersScreenClient> {
  Future<void> _fetch(BuildContext context) async {
    await Provider.of<Orders>(context, listen: false).fetchUserOrders(FirebaseAuth.instance.currentUser.uid);
  }

  bool built = false;
  //Used to access scaffold to open a drawer from custom appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var usersData = Provider.of<Users>(context);

    //Provider.of<Users>(context).fetchClients();
    //Temporary user instance, later will use logged user data
    if (!built) {
      Provider.of<Users>(context, listen: false).fetchClients();
      Provider.of<Orders>(context, listen: false).fetchUserOrders(FirebaseAuth.instance.currentUser.uid);
      built = true;
    }
    //final _loggedUser = usersData.getUserById("6yefDcBz9GbXfGGMeXgh8rwB6CJ2");
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CustomAppbar(_scaffoldKey),
            Container(
              height: deviceSize.height - 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: _fetch(context),
                  builder: (ctx, snapshot) => snapshot.connectionState ==
                          ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: Consumer<Orders>(
                            builder: (ctx, orderData, _) => ListView.builder(
                              itemBuilder: (_, i) => Column(
                                children: [
                                  ClientOrderItem(orderData.allOrders[i]),
                                  Divider()
                                ],
                              ),
                              itemCount: orderData.allOrders.length,
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AddOrderScreen.routeName);
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
