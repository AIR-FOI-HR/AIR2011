import 'package:flutter/material.dart';
import 'app_user.dart';

class Order {
  final String id;
  final DateTime orderDate;
  final bool finished;
  final AppUser buyer;
  final AppUser worker;
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
