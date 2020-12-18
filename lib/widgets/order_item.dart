import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/add_order_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:air_2011/screens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/order.dart';

class OrderItem extends StatelessWidget {
  final Order _thisOrder;
  final AppUser _loggedUser;
  OrderItem(this._thisOrder, this._loggedUser);

//Handles what happens if the delete button has been clicked
  Future<void> _deleteHandler(context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("Delete order?"),
            content: Text("Are you sure you want to delete this order?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    //Need to implement delete functionality
                    //Right now prints buyer's surname
                    debugPrint(_thisOrder.buyer.surname);
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

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      actions: [
        IconSlideAction(
          caption: 'Edit',
          color: Theme.of(context).accentColor,
          icon: Icons.edit,
          //Need to add onTap functionality
          onTap: () => null,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => _deleteHandler(context),
        )
      ],
      child: ListTile(
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
                child: Text(
                    DateFormat('dd/MM/yyyy').format(_thisOrder.orderDate),
                    style: Theme.of(context).textTheme.caption),
              ),
            ],
          ),
          title: Text('Buyer'),
          subtitle:
              Text('${_thisOrder.buyer.name} ${_thisOrder.buyer.surname}'),
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
          )),
    );
  }
}
