import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/orders.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:air_2011/screens/single_order_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

import '../providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order _thisOrder;

  //final AppUser _loggedUser;
  OrderItem(this._thisOrder);

//Handles what happens if the delete button has been clicked
  Future<void> _deleteHandler(context, _buyer) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Delete order?"),
            content: Text("Are you sure you want to delete this order?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    DatabaseManipulator.removeOrder(_thisOrder.id);
                    Provider.of<Orders>(context, listen: false)
                              .fetchOrders();
                    debugPrint(_buyer.surname);
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No")),
            ],
          );
        });
  }
void _updateHandler(context)
{
  DatabaseManipulator.orderPaid(_thisOrder.id, !_thisOrder.isPaid);
       Provider.of<Orders>(context, listen: false).fetchOrders();
}

  @override
  Widget build(BuildContext context) {
    final _usersData = Provider.of<Users>(context, listen: false);
    final AppUser _buyer = _usersData.getUserById(_thisOrder.buyer);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      actions: [
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => _deleteHandler(context, _buyer),
        ),
        IconSlideAction(
          caption: _thisOrder.isPaid? "Unpay" : "Paid",
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => _updateHandler(context),
        )
      ],
      child: ListTile(
        onTap: () {
          //argument UserType will be taken out from logged in user
          Navigator.of(context).pushNamed(SingleOrderScreen.routeName,
              arguments: [_thisOrder, UserType.Admin]);
        },
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Finished',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Icon(
                    _thisOrder.finished
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Theme.of(context).primaryColor,
                    size: 17,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Date', style: Theme.of(context).textTheme.subtitle2),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                        DateFormat('dd/MM/yyyy').format(_thisOrder.orderDate),
                        style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            ),
          ],
        ),
        title: Text('Buyer', style: Theme.of(context).textTheme.subtitle2),
        subtitle: Text('${_buyer.name} ${_buyer.surname}',
            style: Theme.of(context).textTheme.caption),
        trailing: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'HRK',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text('${_thisOrder.total.toString()}',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}
