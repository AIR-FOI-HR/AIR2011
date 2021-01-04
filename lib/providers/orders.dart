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
    _orders.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Order').get();
    for (var doc in querySnapshot.docs) {
      loadedOrders.add(Order(
        buyer: doc.data()['buyer'],
        worker: doc.data()['worker'],
        height: double.tryParse(doc.data()['height'].toString()),
        width: double.tryParse(doc.data()['width'].toString()),
        orderDate: DateTime.now(),
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
      ));
    }
    _orders = loadedOrders;
    notifyListeners();
  }

  
  Future<void> fetchSingleClientOrder(String clientId) async {
    List<Order> loadedOrders = [];
    _orders.clear();
    List<DocumentSnapshot> documentSnapshot =
        await FirebaseFirestore.instance.collection('Order').doc(clientId).snapshots().toList();
    for (var doc in documentSnapshot) {
      loadedOrders.add(Order(
        buyer: doc.data()['buyer'],
        worker: doc.data()['worker'],
        height: double.tryParse(doc.data()['height'].toString()),
        width: double.tryParse(doc.data()['width'].toString()),
        orderDate: DateTime.now(),
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
      ));
    }    
    _orders = loadedOrders;
    notifyListeners();
  }
}
