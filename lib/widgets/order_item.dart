import 'package:air_2011/providers/user.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order _thisOrder;
  final User _loggedUser;
  OrderItem(this._thisOrder, this._loggedUser);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(OrderDetailScreen.routeName,
              arguments: [_thisOrder, _loggedUser.userType]);
        },
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Date', style: Theme.of(context).textTheme.subtitle1),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Text(DateFormat('dd/MM/yyyy').format(_thisOrder.orderDate),
                  style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
        title: Text('Buyer'),
        subtitle: Text('${_thisOrder.buyer.name} ${_thisOrder.buyer.surname}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _thisOrder.finished
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Colors.green,
            ),
            Icon(
              Icons.notifications,
              color: Theme.of(context).accentColor,
            )
          ],
        ));
  }
}
