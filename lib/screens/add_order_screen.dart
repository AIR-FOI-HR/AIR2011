import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:air_2011/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../providers/users.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  static const routeName = 'add-order';
  //static Users _usersData = Users();

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  var _usersDropDownItems = List<DropdownMenuItem>();

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
    usersList.allUsers_hardcoded.forEach((user) {
      _usersDropDownItems.add(DropdownMenuItem(
        child: Text("${user.email}"),
        value: user.id,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
            child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: _textFieldDecoration(
                  'Buyer',
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
                      decoration: _textFieldDecoration("Height"),
                      keyboardType: TextInputType.number,
                      onSaved: null,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: _textFieldDecoration("Width"),
                      keyboardType: TextInputType.number,
                      onSaved: null,
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
                      decoration: _textFieldDecoration("Passpart / Glass Qty"),
                      keyboardType: TextInputType.number,
                      onSaved: null,
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
                      decoration: _textFieldDecoration("Frames included Qty"),
                      keyboardType: TextInputType.number,
                      onSaved: null,
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
                      onSaved: null,
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
                      onSaved: null,
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
                      onSaved: null,
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
                      onSaved: null,
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
                      onSaved: null,
                    ),
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
            ],
          ),
        )),
      ),
      drawer: AppDrawer(),
    );
  }
}
