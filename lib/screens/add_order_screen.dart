import 'package:air_2011/helper/calculate.dart';
import 'package:air_2011/providers/order.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:air_2011/db_managers/db_caller.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  static const routeName = 'add-order';
  //static Users _usersData = Users();

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

Future<void> _fetchUsers(BuildContext context) async {
  await Provider.of<Users>(context, listen: false).fetchClients();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  var _usersDropDownItems = List<DropdownMenuItem>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseManipulator db_caller = new DatabaseManipulator();
  final Calculator calc = new Calculator();
  static String id = "";
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool paid = false;

  Order _model = new Order();
  void calculateSum() {
    _formKey.currentState.save();
    if (_model.width != null &&
        _model.height != null &&
        _model.priceFrameOne != null) {
      _model.total = calc.calculateSum(_model);
    }
  }

  void createNewOrder() async {
    if (_formKey.currentState.validate()) {
      calculateSum();
      final User user = auth.currentUser;
      final uid = user.uid;
      _model.worker = uid;
      _model.isPaid = paid;
      DatabaseManipulator.addNewOrder(_model);
      Navigator.of(context).pushReplacementNamed(ViewOrdersScreen.routeName);
    }
  }

  //We need to check if the first build happen
  //so the DropdownMenuItem won't be built again
  //When first build happens _wasFirstBuild will
  //be true
  bool _wasFirstBuild = false;

  /*_fillDropDownMenu takes user data from passed argument
    and prepares data for DropdownButtonFormField
    in shape of DropdownMenuItems
  */
  void _fillDropDownMenu(usersList) {
    usersList.fetchClients();
    usersList.allUsers.forEach((user) {
      _usersDropDownItems.add(DropdownMenuItem(
        child: Text("${user.email}"),
        value: user.id,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    _fetchUsers(context);
    var _usersData = Provider.of<Users>(context);

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
      _fillDropDownMenu(_usersData);
      _wasFirstBuild = true;
    }

    //bool _isCheckedBorder = false;
    //bool _isCheckedPass = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new order',
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
                  DropdownButtonFormField(
                    decoration: _textFieldDecoration(
                      'Buyer',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a user.';
                      }
                      return null;
                    },
                    items: _usersDropDownItems,
                    onChanged: (input) => _model.buyer = input,
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
                          onChanged: (input) => {
                            _model.height = double.parse(input),
                            calculateSum()
                          },
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
                            onChanged: (input) => {
                                  _model.width = double.parse(input),
                                  calculateSum()
                                }),
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
                            onChanged: (input) => {
                                  _model.passpartoutGlass = int.parse(input),
                                  calculateSum()
                                }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       fit: FlexFit.loose,
                  //       child: TextFormField(
                  //         decoration:
                  //             _textFieldDecoration("Frames included Qty"),
                  //         keyboardType: TextInputType.number,
                  //         onSaved: null,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                            onChanged: (input) => {
                                  _model.priceFrameOne = double.parse(input),
                                  calculateSum()
                                }),
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
                              if (_model.priceFrameTwo != null) {
                                if (double.parse(value) >= _model.width ||
                                    double.parse(value) >= _model.height ||
                                    double.parse(value) < 0) {
                                  return 'The value is invalid!';
                                }
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (input) => {
                                  _model.spaceFrameTwo = double.parse(input),
                                  calculateSum()
                                }),
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
                                    {_model.priceFrameTwo = null}
                                  else
                                    {
                                      _model.priceFrameTwo = double.parse(input)
                                    },
                                  calculateSum()
                                }),
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
                              if (_model.priceFrameThree != null) {
                                if ((double.parse(value)) >= _model.width ||
                                    double.parse(value) >= _model.height ||
                                    double.parse(value) < 0) {
                                  return 'The value is invalid!';
                                }
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (input) => {
                                  _model.spaceFrameThree = double.parse(input),
                                  calculateSum()
                                }),
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
                                }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:${_model.total == null ? "0" : _model.total} HRK',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(color: paid ? Colors.green : Colors.red),
                      ),
                      Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                paid = !paid;
                              });
                            },
                            child: Text(
                              paid ? 'Paid' : 'Not paid',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            color: paid
                                ? Colors.green
                                : Theme.of(context).errorColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 3)),
                            height: 50,
                            minWidth: 100,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FlatButton(
                            onPressed: () {
                              createNewOrder();
                            },
                            child: Text(
                              'Save',
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
                          )
                        ],
                      ),
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
