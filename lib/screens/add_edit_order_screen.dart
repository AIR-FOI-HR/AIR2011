import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:flutter/material.dart';

class AddEditOrderScreen extends StatelessWidget {
  static const routeName = 'add-edit-order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO add/edit order screen implementation'),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(ViewOrdersScreen.routeName);
            },
            child: Text('return'),
          )
        ],
      ),
    );
  }
}
