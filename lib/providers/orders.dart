import 'package:air_2011/providers/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  List<Order> _filteredOrders = [];

  //Getter for orders list
  List<Order> get allOrders {
    return [..._orders];
  }

  List<Order> get filteredOrders {
    return [..._filteredOrders];
  }

  Future<void> fetchOrders() async {
    List<Order> loadedOrders = [];
    _orders.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Order').get();
    for (var doc in querySnapshot.docs) {
      loadedOrders.add(Order(
        id: doc.id,
        buyer: doc.data()['buyer'],
        worker: doc.data()['worker'],
        height: double.tryParse(doc.data()['height'].toString()),
        width: double.tryParse(doc.data()['width'].toString()),
        orderDate:
            DateTime.parse((doc.data()['orderDate'].toDate().toString())),
        passpartoutGlass: doc.data()['passpartoutGlass'],
        priceFrameOne: double.tryParse(doc.data()['priceFrameOne'].toString()),
        priceFrameTwo: double.tryParse(doc.data()['priceFrameTwo'].toString()),
        spaceFrameTwo: double.tryParse(doc.data()['spaceFrameTwo'].toString()),
        priceFrameThree:
            double.tryParse(doc.data()['priceFrameThree'].toString()),
        spaceFrameThree:
            double.tryParse(doc.data()['spaceFrameThree'].toString()),
        total: double.tryParse(doc.data()['total'].toString()),
        finished: doc.data()['finished'],
        isPaid: doc.data()['isPaid'],
      ));
    }
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> fetchUserOrders(userid) async {
    List<Order> loadedOrders = [];
    _orders.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Order').get();
    for (var doc in querySnapshot.docs) {
      if (doc.data()['buyer'] == userid) {
        loadedOrders.add(Order(
          id: doc.id,
          buyer: doc.data()['buyer'],
          worker: doc.data()['worker'],
          height: double.tryParse(doc.data()['height'].toString()),
          width: double.tryParse(doc.data()['width'].toString()),
          orderDate: DateTime.now(),
          passpartoutGlass: doc.data()['passpartoutGlass'],
          priceFrameOne:
              double.tryParse(doc.data()['priceFrameOne'].toString()),
          priceFrameTwo:
              double.tryParse(doc.data()['priceFrameTwo'].toString()),
          spaceFrameTwo:
              double.tryParse(doc.data()['spaceFrameTwo'].toString()),
          priceFrameThree:
              double.tryParse(doc.data()['priceFrameThree'].toString()),
          spaceFrameThree:
              double.tryParse(doc.data()['spaceFrameThree'].toString()),
          total: double.tryParse(doc.data()['total'].toString()),
          finished: doc.data()['finished'],
          isPaid: doc.data()['isPaid'],
        ));
      }
    }
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> filterByNotCompleted() async {
    List<Order> filteredOrders = _orders.toList();
    filteredOrders.removeWhere((element) => element.finished == true);
    _filteredOrders.clear();
    _filteredOrders = filteredOrders;
  }

  Future<void> filterByCompleted() async {
    List<Order> filteredOrders = _orders.toList();
    filteredOrders.removeWhere((element) => element.finished == false);
    _filteredOrders.clear();
    _filteredOrders = filteredOrders;
  }

  Future<void> filterByDate(DateTime pickedDate) async {
    List<Order> filteredOrders = _orders.toList();
    filteredOrders.removeWhere((element) =>
        DateFormat.yMd().format(element.orderDate) !=
        DateFormat.yMd().format(pickedDate));
    _filteredOrders.clear();
    _filteredOrders = filteredOrders;
  }

  Future<void> filterByBuyer(AppUser buyer) async {
    List<Order> filteredOrders = _orders.toList();
    filteredOrders.removeWhere((element) => element.buyer != buyer.id);
    _filteredOrders.clear();
    _filteredOrders = filteredOrders;
  }
}
