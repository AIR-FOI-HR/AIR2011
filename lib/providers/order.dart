import 'package:flutter/material.dart';
import 'app_user.dart';

class Order {
  String id;
  DateTime orderDate;
  bool finished;
  String buyer;
  String worker;
  double height;
  double width;
  int passpartoutGlass;
  double priceFrameOne;
  double priceFrameTwo;
  double spaceFrameTwo;
  double priceFrameThree;
  double spaceFrameThree;
  double total;

  Order(
      {this.id,
      this.orderDate,
      this.finished = false,
      this.buyer,
      this.worker,
      this.height,
      this.width,
      this.passpartoutGlass = 1,
      this.priceFrameOne,
      this.priceFrameTwo,
      this.priceFrameThree,
      this.spaceFrameTwo,
      this.spaceFrameThree,
      this.total});
}
