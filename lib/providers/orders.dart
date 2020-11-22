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
        buyer: users.allUsers[1],
        worker: users.allUsers[0],
        height: 20,
        width: 20,
        passpartout: 20,
        finished: true),
    Order(
        id: '2',
        orderDate: DateTime.now(),
        buyer: users.allUsers[2],
        worker: users.allUsers[0],
        height: 20,
        width: 20,
        passpartout: 20,
        border: true,
        doublePasspartout: true),
    Order(
        id: '3',
        orderDate: DateTime.now(),
        buyer: users.allUsers[3],
        worker: users.allUsers[0],
        height: 20,
        width: 20,
        passpartout: 20,
        finished: true),
    Order(
      id: '4',
      orderDate: DateTime.now(),
      buyer: users.allUsers[4],
      worker: users.allUsers[0],
      height: 20,
      width: 20,
      passpartout: 20,
    ),
    Order(
      id: '5',
      orderDate: DateTime.now(),
      buyer: users.allUsers[5],
      worker: users.allUsers[0],
      height: 20,
      width: 20,
      passpartout: 20,
    ),
    Order(
      id: '6',
      orderDate: DateTime.now(),
      buyer: users.allUsers[5],
      worker: users.allUsers[0],
      height: 40,
      width: 20,
      passpartout: 20,
    ),
  ];

  //Getter for orders list
  List<Order> get allOrders {
    return [..._orders];
  }
}
