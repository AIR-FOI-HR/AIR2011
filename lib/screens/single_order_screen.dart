import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
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

  Order _model = new Order();

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
                    "Outside (def. frame)",
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
                    "Outside (def. frame)",
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
                          'Total:${_model.total}HRK',
                          style: Theme.of(context).textTheme.headline6,
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
                          onPressed: () {},
                          child: Text('Update',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3)),
                          height: 50,
                          minWidth: 100,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text('Done',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 3)),
                          height: 50,
                          minWidth: 100,
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () {
                          calculateSum();
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).accentColor,
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
      drawer: AppDrawer(),
    );
  }
}
