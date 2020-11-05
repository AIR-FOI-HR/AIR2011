import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class AddOrderScreen extends StatefulWidget {
  static const routeName = 'add-order';
  static Users _usersData = Users();

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  var _usersDropDownItems = List<DropdownMenuItem>();

  /*on initState takes user data from Users()
    repository and prepares data for DropdownButtonFormField
    in shape of DropdownMenuItems
  */
  @override
  void initState() {
    AddOrderScreen._usersData.allUsers.forEach((user) {
      _usersDropDownItems.add(DropdownMenuItem(
        child: Text("${user.email}"),
        value: user.id,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    bool _isCheckedBorder = false;
    bool _isCheckedPass = false;
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
          child: FooterView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Buyer',
                      ),
                      items: _usersDropDownItems,
                      onChanged: (_) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Height"),
                            keyboardType: TextInputType.number,
                            onSaved: null,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: "Width"),
                            keyboardType: TextInputType.number,
                            onSaved: null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Passpartout"),
                            keyboardType: TextInputType.number,
                            onSaved: null,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Number of Glasses"),
                            keyboardType: TextInputType.number,
                            onSaved: null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Flexible(
                            child: CheckboxListTile(
                              value: _isCheckedBorder,
                              onChanged: (bool value) {
                                setState(() {
                                  _isCheckedBorder = value;
                                });
                              },
                              title: Text(
                                'Border',
                                style: TextStyle(fontSize: 16),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          );
                        }),
                        StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Flexible(
                            child: CheckboxListTile(
                              value: _isCheckedPass,
                              onChanged: (bool value) {
                                setState(() {
                                  _isCheckedPass = value;
                                });
                              },
                              title: Text(
                                'Double passepartout',
                                style: TextStyle(fontSize: 14),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              )
            ],
            footer: Footer(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //TODO implement calculator
                    Text(
                      'Total: 0 HRK',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(ViewOrdersScreen.routeName);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: Theme.of(context).accentColor, width: 3)),
                      height: 50,
                      minWidth: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
