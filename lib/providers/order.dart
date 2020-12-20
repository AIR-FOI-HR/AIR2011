import 'package:flutter/material.dart';
import 'app_user.dart';

class Order {
   String id;
   DateTime orderDate;
   bool finished;
   AppUser buyer;
   AppUser worker;
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
      {@required this.id,
      @required this.orderDate,
      this.finished = false,
      @required this.buyer,
      @required this.worker,
      @required this.height,
      @required this.width,
      @required this.passpartoutGlass = 1,
      @required this.priceFrameOne,
      this.priceFrameTwo,
      this.priceFrameThree,
      this.spaceFrameTwo,
      this.spaceFrameThree,
      @required this.total});
}
