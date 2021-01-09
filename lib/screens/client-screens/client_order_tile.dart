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
                    //Need to implement delete functionality
                    //Right now prints buyer's surname
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

  @override
  Widget build(BuildContext context) {
    final _usersData = Provider.of<Users>(context, listen: false);
    final AppUser _buyer = _usersData.getUserById(_thisOrder.buyer);
    return  ListTile(
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
                child: Text(
                    DateFormat('dd/MM/yyyy').format(_thisOrder.orderDate),
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
                color: Colors.green,
              ),
            ],
          ));
  }
}
