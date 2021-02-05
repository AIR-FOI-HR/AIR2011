import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/providers/orders.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';

import 'client-screens/client_order_tile.dart';

class UserOrderList extends StatefulWidget {
  static const routeName = 'user-order-list';
  //static Users _usersData = Users();

  @override
  _UserOrderListState createState() => _UserOrderListState();
}

class _UserOrderListState extends State<UserOrderList> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final AppUser _selectedUser = args[0];
    final deviceSize = MediaQuery.of(context).size;

    Future<void> _fetch() async {
      await Provider.of<Orders>(context, listen: false)
          .fetchUserOrders(_selectedUser.id);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            _selectedUser.name + " " + _selectedUser.surname + ' Orders',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: Container(
          child: Column(children: [
            Container(
              height: deviceSize.height - 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: _fetch(),
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
            ),
          ]),
        ));
  }
}
