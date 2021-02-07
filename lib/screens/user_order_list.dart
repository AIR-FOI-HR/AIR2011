import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/orders.dart';
import 'package:flutter/material.dart';
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
        child: FutureBuilder(
            future: _fetch(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                          height: deviceSize.height - 250,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).dividerColor),
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(children: [
                              Text('Total to pay ',
                                  style: Theme.of(context).textTheme.subtitle2),
                              Text(
                                  '${Provider.of<Orders>(context, listen: false).totalToPay} HRK',
                                  style: Theme.of(context).textTheme.caption),
                            ]),
                            Row(children: [
                              Text('Total paid ',
                                  style: Theme.of(context).textTheme.subtitle2),
                              Text(
                                  '${Provider.of<Orders>(context, listen: false).totalPaid} HRK',
                                  style: Theme.of(context).textTheme.caption),
                            ]),
                            Row(children: [
                              Text('Total ',
                                  style: Theme.of(context).textTheme.subtitle2),
                              Text(
                                  '${Provider.of<Orders>(context, listen: false).totalPrice} HRK',
                                  style: Theme.of(context).textTheme.caption),
                            ])
                          ]))
                    ],
                  )),
      ),
    );
  }
}
