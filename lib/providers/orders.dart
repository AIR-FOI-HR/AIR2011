import 'package:flutter/cupertino.dart';

import './order.dart';
import './users.dart';

class Orders with ChangeNotifier {
  static Users users = Users();

  //Hardcoded list of orders
  List<Order> _orders = [
    Order(
        id: '1',
        orderDate: DateTime.now(),
        buyer: users.allUsers_hardcoded[1],
        worker: users.allUsers_hardcoded[0],
        height: 20,
        width: 20,
        passpartoutGlass: 3,
        finished: true,
        priceFrameOne: 24.5,
        priceFrameTwo: 16,
        spaceFrameTwo: 2.5,
        total: 200.20,
        ),
        Order(
        id: '2',
        orderDate: DateTime.now(),
        buyer: users.allUsers_hardcoded[1],
        worker: users.allUsers_hardcoded[0],
        height: 20,
        width: 20,
        passpartoutGlass: 3,
        finished: false,
        priceFrameOne: 24.5,
        priceFrameTwo: 16,
        spaceFrameTwo: 2.5,
        total: 200.20,
        ),
        Order(
        id: '3',
        orderDate: DateTime.now(),
        buyer: users.allUsers_hardcoded[1],
        worker: users.allUsers_hardcoded[0],
        height: 20,
        width: 20,
        passpartoutGlass: 3,
        finished: true,
        priceFrameOne: 24.5,
        priceFrameTwo: 16,
        spaceFrameTwo: 2.5,
        total: 200.20,
        ),

  ];

  //Getter for orders list
  List<Order> get allOrders {
    return [..._orders];
  }
}
