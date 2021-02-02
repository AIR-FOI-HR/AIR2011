import 'package:air_2011/db_managers/notifications.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/providers/users.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';

class SingleOrderClientScreen extends StatefulWidget {
  static const routeName = 'single-order-client';
  //static Users _usersData = Users();

  @override
  _SingleOrderClientScreenState createState() =>
      _SingleOrderClientScreenState();
}

class _SingleOrderClientScreenState extends State<SingleOrderClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Order _model = new Order();

  void initState() {
    super.initState();
    setUpNotificationSystem(context);
  }

  static bool necessaryFilled = false;
  void calculateSum() {
    if (_formKey.currentState.validate()) {
      var surface = (_model.width / 100) * (_model.height / 100);
      print(_model.width);
      print(_model.height);
      var volume = 2 * (_model.width / 100) + 2 * (_model.height / 100);

      _model.total = (volume * _model.passpartoutGlass * 90) +
          (surface * _model.priceFrameOne);

      if (_model.spaceFrameTwo != null && _model.priceFrameTwo != null) {
        var tmpVol2 = ((_model.width - _model.spaceFrameTwo) / 100) *
            ((_model.height - _model.spaceFrameTwo) / 100);
        _model.total += tmpVol2 * _model.priceFrameTwo;
      }
      if (_model.spaceFrameThree != null && _model.priceFrameThree != null) {
        var tmpVol3 = ((_model.width - _model.spaceFrameThree) / 100) *
            ((_model.height - _model.spaceFrameThree) / 100);
        _model.total += tmpVol3 * _model.priceFrameThree;
      }
      _model.total = double.parse(_model.total.toStringAsFixed(2));
      print(_model.total);
    }
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
    final Order _orderInfo = args[0];
    final UserType _loggedInUserType = args[1];
    final deviceSize = MediaQuery.of(context).size;

    final _usersData = Provider.of<Users>(context, listen: false);
    final AppUser _buyer = _usersData.getUserById(_orderInfo.buyer);

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
                              _model.height = double.parse(input),
                          readOnly: true,
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
                              _model.width = double.parse(input),
                          readOnly: true,
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
                              _model.passpartoutGlass = int.parse(input),
                          readOnly: true,
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
                              _model.priceFrameOne = double.parse(input),
                          initialValue: "${_orderInfo.priceFrameOne}",
                          readOnly: true,
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
                              _model.spaceFrameTwo = double.parse(input),
                          initialValue:
                              "${checkIfNull(_orderInfo.spaceFrameTwo)}",
                          readOnly: true,
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
                              _model.priceFrameTwo = double.parse(input),
                          initialValue:
                              "${checkIfNull(_orderInfo.priceFrameTwo)}",
                          readOnly: true,
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
                            _model.spaceFrameThree = double.parse(input),
                            calculateSum()
                          },
                          initialValue:
                              "${checkIfNull(_orderInfo.spaceFrameThree)}",
                          readOnly: true,
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
                            _model.priceFrameThree = double.parse(input),
                            calculateSum()
                          },
                          initialValue:
                              "${checkIfNull(_orderInfo.priceFrameThree)}",
                          readOnly: true,
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
                          'Total:${_orderInfo.total}HRK',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
