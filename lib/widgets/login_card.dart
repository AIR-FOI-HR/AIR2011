import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginCard extends StatelessWidget {
  /*Function handler for changing between
    Login screen and Registration/Signup screen
  */

  FirebaseAuth auth = FirebaseAuth.instance;
  final Function changeScreenHandler;
  final GlobalKey<FormState> _formKey;
  LoginCard(this.changeScreenHandler, this._formKey);
  static String _email, _password;

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
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (input) => _password = input,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    signIn(context);
                  },
                  child: Text("Login"),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    changeScreenHandler();
                  },
                  child: Text("Signup instead"),
                  textColor: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Theme.of(context).accentColor, width: 3)),
                ),
              ],
            ),
          )),
    );
  }

  void signIn(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthenticationManipulator.loginUser(context, _email, _password);
    }
  }
}
