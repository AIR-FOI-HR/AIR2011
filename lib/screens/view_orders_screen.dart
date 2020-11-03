import 'package:air_2011/screens/add_edit_order_screen.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:air_2011/widgets/order_item.dart';
import 'package:flutter/material.dart';

import '../providers/orders.dart';
import '../widgets/drawer.dart';

class ViewOrdersScreen extends StatefulWidget {
  static const routeName = 'orders-screen';

  static Orders ordersData = Orders();

  @override
  _ViewOrdersScreenState createState() => _ViewOrdersScreenState();
}

class _ViewOrdersScreenState extends State<ViewOrdersScreen> {
  //used to access scaffold to open a drawer outside of appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _loggedUser = ViewOrdersScreen.ordersData.allOrders[1].buyer;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        }),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      child: Text(
                        "${_loggedUser.name[0]}${_loggedUser.surname[0]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: deviceSize.height - 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (_, i) => Column(
                    children: [
                      OrderItem(ViewOrdersScreen.ordersData.allOrders[i]),
                      Divider()
                    ],
                  ),
                  itemCount: ViewOrdersScreen.ordersData.allOrders.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(AddEditOrderScreen.routeName);
        },
      ),
      drawer: AppDrawer(_loggedUser.name),
    );
  }
}
