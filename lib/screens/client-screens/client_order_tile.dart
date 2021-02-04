import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/providers/users.dart';
import 'package:air_2011/screens/client-screens/order_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientOrderItem extends StatelessWidget {
  final Order _thisOrder;

  //final AppUser _loggedUser;
  ClientOrderItem(this._thisOrder);

  @override
  Widget build(BuildContext context) {
    setUpNotificationSystem(context);

    return ListTile(
        onTap: () {
          //argument UserType will be taken out from logged in user
          Navigator.of(context).pushNamed(SingleOrderClientScreen.routeName,
              arguments: [_thisOrder, UserType.Admin]);
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
        title: Text('Price'),
        subtitle: Text('${_thisOrder.total} HRK'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _thisOrder.finished
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ));
  }
}
