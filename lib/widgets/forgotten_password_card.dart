import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgottenCard extends StatelessWidget {
  /*Function handler for changing between
    Login screen and Registration/Signup screen
  */

  FirebaseAuth auth = FirebaseAuth.instance;
  final Function changeScreenHandler;
  final GlobalKey<FormState> _formKey;
  ForgottenCard(this.changeScreenHandler, this._formKey);
  static String _email;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(labelText: "E-Mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (input) => _email = input),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    forgotPassword(context);
                    //closes keyboard if not closed
                    FocusScope.of(context).unfocus();
                  },
                  child: Text("Reset Password"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {
                    //closes keyboard if not closed
                    FocusScope.of(context).unfocus();
                    changeScreenHandler("Login");
                  },
                  child: Text("Back"),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3)),
                )
              ],
            ),
          )),
    );
  }

  void forgotPassword(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_email);
      AuthenticationManipulator.forgotPassword(context, _email);
    }
  }
}
