import 'package:air_2011/db_managers/db_caller.dart';
import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/providers/orders.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
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

  static bool necessaryFilled = false;

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

    final _usersData = Provider.of<Users>(context, listen: false);
    _buyer = _usersData.getUserById(_orderInfo.buyer);

    void calculateSum() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        var surface = (_orderInfo.width / 100) * (_orderInfo.height / 100);
        print(_orderInfo.width);
        print(_orderInfo.height);
        var volume =
            2 * (_orderInfo.width / 100) + 2 * (_orderInfo.height / 100);

        _orderInfo.total = (volume * _orderInfo.passpartoutGlass * 90) +
            (surface * _orderInfo.priceFrameOne);

        if (_orderInfo.spaceFrameTwo != null &&
            _orderInfo.priceFrameTwo != null) {
          var tmpVol2 = ((_orderInfo.width - _orderInfo.spaceFrameTwo) / 100) *
              ((_orderInfo.height - _orderInfo.spaceFrameTwo) / 100);
          _orderInfo.total += tmpVol2 * _orderInfo.priceFrameTwo;
        }
        if (_orderInfo.spaceFrameThree != null &&
            _orderInfo.priceFrameThree != null) {
          var tmpVol3 =
              ((_orderInfo.width - _orderInfo.spaceFrameThree) / 100) *
                  ((_orderInfo.height - _orderInfo.spaceFrameThree) / 100);
          _orderInfo.total += tmpVol3 * _orderInfo.priceFrameThree;
        }
        setState(() {
          _orderInfo.total = double.parse(_orderInfo.total.toStringAsFixed(2));
        });

        print(_orderInfo.total);
      }
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
      // print(_orderInfo.id);
      calculateSum();
      // _formKey.currentState.save();

      DatabaseManipulator.updateOrder(_orderInfo);
      Provider.of<Orders>(context, listen: false).fetchOrders();
      // Navigator.of(context).pushReplacementNamed(ViewOrdersScreen.routeName);
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

    //bool _isCheckedBorder = false;
    //bool _isCheckedPass = false;
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
                          onChanged: (input) =>
                              _orderInfo.priceFrameTwo = double.parse(input),
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
                          keyboardType: TextInputType.number,
                          onChanged: (input) => {
                            _orderInfo.spaceFrameThree = double.parse(input),
                            calculateSum()
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
                            calculateSum()
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
                          //doesn't calculate right now, just takes total from DB
                          'Total:${_orderInfo.total == null ? "0" : _orderInfo.total}HRK',
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
                        //TODO implement calculator

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
