import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/helper/calculate.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/providers/orders.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:provider/provider.dart';

class SingleOrderScreen extends StatefulWidget {
  static const routeName = 'single-order';
  //static Users _usersData = Users();

  @override
  _SingleOrderScreenState createState() => _SingleOrderScreenState();
}

class _SingleOrderScreenState extends State<SingleOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AppUser _buyer;

  void initState() {
    super.initState();
    setUpNotificationSystem(context);
  }

  //Function returns empty string or real value depending on
  //variable value in Order so we won't have null values in
  //order item fields
  String checkIfNull(double value) {
    if (value == null) {
      return "";
    } else {
      return value.toString();
    }
  }

  //We need to check if the first build happen
  //so the DropdownMenuItem won't be built again
  //When first build happens _wasFirstBuild will
  //be true
  bool _wasFirstBuild = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List;
    Order _orderInfo = args[0];

    final deviceSize = MediaQuery.of(context).size;
    final Calculator calc = new Calculator();
    final _usersData = Provider.of<Users>(context, listen: false);
    _buyer = _usersData.getUserById(_orderInfo.buyer);

    void calculateSum() {
      _formKey.currentState.save();

      setState(() {
        _orderInfo.total = calc.calculateSum(_orderInfo);
      });
    }

    void completetionSwitch() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _orderInfo.finished = !_orderInfo.finished;
        });
        DatabaseManipulator.orderFinished(_orderInfo.id, _orderInfo.finished);
        if (_orderInfo.finished) {
          sendNotification(_buyer);
        }
        Provider.of<Orders>(context, listen: false).fetchOrders();
      }
    }

    void paidSwitch() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        setState(() {
          _orderInfo.isPaid = !_orderInfo.isPaid;
        });
        DatabaseManipulator.orderPaid(_orderInfo.id, _orderInfo.isPaid);
        Provider.of<Orders>(context, listen: false).fetchOrders();
      }
    }

    void updateOrder() async {
      if (_formKey.currentState.validate()) {
        calculateSum();

        DatabaseManipulator.updateOrder(_orderInfo);
        Provider.of<Orders>(context, listen: false).fetchOrders();
      }
    }

    //Return custom InputDecoration for text fields
    InputDecoration _textFieldDecoration(String text) {
      return InputDecoration(
        contentPadding: EdgeInsets.all(15),
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      );
    }

    //First build check
    if (!_wasFirstBuild) {
      _wasFirstBuild = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        width: deviceSize.width,
        padding: EdgeInsets.all(25),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Buyer's name : ${_buyer.name} ${_buyer.surname}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: _textFieldDecoration("Height"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter height.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          initialValue: "${_orderInfo.height}",
                          onChanged: (input) =>
                              _orderInfo.height = double.parse(input),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: _textFieldDecoration("Width"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter width.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          initialValue: "${_orderInfo.width}",
                          onChanged: (input) =>
                              _orderInfo.width = double.parse(input),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration:
                              _textFieldDecoration("Passpart / Glass Qty"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter qty.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          initialValue: "${_orderInfo.passpartoutGlass}",
                          onChanged: (input) =>
                              _orderInfo.passpartoutGlass = int.parse(input),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Outside (main frame)",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration: _textFieldDecoration("Price/m2"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter price of main frame.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (input) =>
                              _orderInfo.priceFrameOne = double.parse(input),
                          initialValue: "${_orderInfo.priceFrameOne}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Outside (optional frame)",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration: _textFieldDecoration("Space (cm)"),
                          validator: (value) {
                            if (_orderInfo.priceFrameTwo != null) {
                              if (double.parse(value) >= _orderInfo.width ||
                                  double.parse(value) >= _orderInfo.height ||
                                  double.parse(value) < 0) {
                                return 'The value is invalid!';
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (input) =>
                              _orderInfo.spaceFrameTwo = double.parse(input),
                          initialValue:
                              "${checkIfNull(_orderInfo.spaceFrameTwo)}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration: _textFieldDecoration("Price/m2"),
                          keyboardType: TextInputType.number,
                          onChanged: (input) => {
                            if (input.isEmpty)
                              {_orderInfo.priceFrameTwo = null}
                            else
                              {_orderInfo.priceFrameTwo = double.parse(input)}
                          },
                          initialValue:
                              "${checkIfNull(_orderInfo.priceFrameTwo)}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    "Outside (optional frame)",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration: _textFieldDecoration("Space (cm)"),
                          validator: (value) {
                            if (_orderInfo.priceFrameThree != null) {
                              if ((double.parse(value)) >= _orderInfo.width ||
                                  double.parse(value) >= _orderInfo.height ||
                                  double.parse(value) < 0) {
                                return 'The value is invalid!';
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onChanged: (input) => {
                            _orderInfo.spaceFrameThree = double.parse(input),
                          },
                          initialValue:
                              "${checkIfNull(_orderInfo.spaceFrameThree)}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextFormField(
                          decoration: _textFieldDecoration("Price/m2"),
                          keyboardType: TextInputType.number,
                          onChanged: (input) => {
                            _orderInfo.priceFrameThree = double.parse(input),
                          },
                          initialValue:
                              "${checkIfNull(_orderInfo.priceFrameThree)}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:${_orderInfo.total == null ? "0.00" : _orderInfo.total.toStringAsFixed(2)}HRK',
                          style: Theme.of(context).textTheme.headline6.apply(
                              color: _orderInfo.isPaid
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          onPressed: () {
                            updateOrder();
                          },
                          child: Text('Update',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          height: 50,
                          minWidth: 100,
                        ),
                        FlatButton(
                          onPressed: () {
                            completetionSwitch();
                          },
                          child: Text(_orderInfo.finished ? 'Undone' : 'Done',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          height: 50,
                          minWidth: 100,
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: () {
                          DatabaseManipulator.removeOrder(_orderInfo.id);
                          Provider.of<Orders>(context, listen: false)
                              .fetchOrders();
                          Navigator.pushReplacementNamed(
                              context, ViewOrdersScreen.routeName);
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3)),
                        height: 50,
                        minWidth: 100,
                      ),
                      FlatButton(
                        onPressed: () {
                          paidSwitch();
                        },
                        child: Text(
                          _orderInfo.isPaid ? 'Paid' : 'Not paid',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: _orderInfo.isPaid
                            ? Colors.green
                            : Theme.of(context).errorColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3)),
                        height: 50,
                        minWidth: 100,
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
