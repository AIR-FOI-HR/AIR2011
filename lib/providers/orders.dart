import 'package:cloud_firestore/cloud_firestore.dart';
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
      buyer: "1",
      worker: "2",
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
      buyer: "3",
      worker: "1",
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
      buyer: "4",
      worker: "1",
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

  Future<void> fetchOrders() async {
    List<Order> loadedOrders = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Order').get();
    for (var doc in querySnapshot.docs) {
      loadedOrders.add(Order(
        buyer: doc.data()['buyer'],
        worker: doc.data()['worker'],
        height: doc.data()['height'],
        width: doc.data()['width'],
        orderDate: DateTime.now(),
        passpartoutGlass: doc.data()['passpartoutGlass'],
        priceFrameOne: doc.data()['priceFrameOne'],
        priceFrameTwo: doc.data()['priceFrameTwo'],
        spaceFrameTwo: doc.data()['spaceFrameTwo'],
        priceFrameThree: doc.data()['priceFrameThree'],
        spaceFrameThree: doc.data()['spaceFrameThree'],
        total: doc.data()['total'],
        finished: doc.data()['finished'],
      ));
    }
    _orders = loadedOrders;
    notifyListeners();
  }
}
