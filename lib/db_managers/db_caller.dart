import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'notifications.dart';

class DatabaseManipulator with ChangeNotifier {
  static void createUser(AppUser client) {
    CollectionReference clients =
        FirebaseFirestore.instance.collection('Clients');
    clients.doc(client.id).set({
      'ClientId': client.id,
      'Name': client.name,
      'Surname': client.surname,
      'Email': client.email,
      'FcmToken': client.fcmToken
    }).then((value) => print("User has been added"));
  }

  static void addNewOrder(Order order) {
    CollectionReference orders = FirebaseFirestore.instance.collection('Order');
    orders.add({
      'buyer': order.buyer,
      'worker': order.worker,
      'height': order.height,
      'width': order.width,
      'orderDate': DateTime.now(),
      'passpartoutGlass': order.passpartoutGlass,
      'priceFrameOne': order.priceFrameOne,
      'priceFrameTwo': order.priceFrameTwo,
      'spaceFrameTwo': order.spaceFrameTwo,
      'priceFrameThree': order.priceFrameThree,
      'spaceFrameThree': order.spaceFrameThree,
      'total': order.total,
      'finished': order.finished,
    }).then((value) => print("A new order has been added"));
  }

  static void removeOrder(String uid) {
    CollectionReference orders = FirebaseFirestore.instance.collection('Order');
    orders
        .doc(uid)
        .delete()
        .then((value) => print("The order has been deleted"));
  }

  static void updateOrder(Order order) {
    CollectionReference orders = FirebaseFirestore.instance.collection('Order');
    orders.doc(order.id).update({
      'height': order.height,
      'width': order.width,
      'orderDate': DateTime.now(),
      'passpartoutGlass': order.passpartoutGlass,
      'priceFrameOne': order.priceFrameOne,
      'priceFrameTwo': order.priceFrameTwo,
      'spaceFrameTwo': order.spaceFrameTwo,
      'priceFrameThree': order.priceFrameThree,
      'spaceFrameThree': order.spaceFrameThree,
      'total': order.total,
      'finished': order.finished,
    }).then((value) => print("Order has been updated"));
  }
  
static void orderFinished(String uid, bool finished) {
    CollectionReference orders = FirebaseFirestore.instance.collection('Order');
    orders.doc(uid).update({
      'finished': finished,
    }).then((value) => print("Order has been updated"));
  }
  static Future<void> addTokenToUser(String userId) async {
    String fcmToken = await returnCurrentFcmToken();
    CollectionReference clients =
        FirebaseFirestore.instance.collection('Clients');
    clients.doc(userId).update({'FcmToken': fcmToken});
  }

  static void removeTokenFromUser(String userId) async {
    CollectionReference clients =
        FirebaseFirestore.instance.collection('Clients');
    clients.doc(userId).update({'FcmToken': ''});
  }
}
