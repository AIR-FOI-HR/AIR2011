import 'package:air_2011/screens/add_order_screen.dart';

import '../providers/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/app_user.dart';

class OrderDetailScreen extends StatelessWidget {
  static const routeName = 'order-detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    final Order _orderInfo = args[0];
    final UserType _loggedInUserType = args[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Detail',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name Surname:',
                      style: Theme.of(context).textTheme.headline6),
                  Text("${_orderInfo.buyer.name} ${_orderInfo.buyer.surname}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order made by:',
                      style: Theme.of(context).textTheme.headline6),
                  Text("${_orderInfo.worker.name} ${_orderInfo.worker.surname}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order date:',
                      style: Theme.of(context).textTheme.headline6),
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(_orderInfo.orderDate)}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status:', style: Theme.of(context).textTheme.headline6),
                  _orderInfo.finished
                      ? Text(
                          'Finished',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontSize,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'Not yet finished',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Height of frame:',
                      style: Theme.of(context).textTheme.headline6),
                  Text("${_orderInfo.height}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Width of frame:',
                      style: Theme.of(context).textTheme.headline6),
                  Text("${_orderInfo.width}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Border:', style: Theme.of(context).textTheme.headline6),
                  Icon(
                    _orderInfo.border
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Double passpartout:',
                      style: Theme.of(context).textTheme.headline6),
                  Icon(
                    _orderInfo.doublePasspartout
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Number of glasses:',
                      style: Theme.of(context).textTheme.headline6),
                  Text("${_orderInfo.glassNumber}",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _loggedInUserType == UserType.Admin
          ? FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(AddOrderScreen.routeName);
              },
            )
          : null,
    );
  }
}
