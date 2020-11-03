import 'package:flutter/material.dart';
import './user.dart';

class Order {
  final String id;
  final DateTime orderDate;
  final bool finished;
  final User buyer;
  final User worker;
  final double height;
  final double width;
  final double passpartout;
  final int glassNumber;
  final bool border;
  final bool doublePasspartout;

  Order(
      {@required this.id,
      @required this.orderDate,
      this.finished = false,
      @required this.buyer,
      @required this.worker,
      @required this.height,
      @required this.width,
      this.border = false,
      this.glassNumber = 1,
      this.doublePasspartout = false,
      @required this.passpartout});
}
