import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/view_orders_screen.dart';

class SignupCard extends StatelessWidget {
  InputDecoration _textFieldDecoration(
      String text, BuildContext context, Icon icon) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(15),
      labelText: text,
      prefixIcon: icon,
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

  final Function changeScreenHandler;
  final GlobalKey<FormState> _formKey;
  SignupCard(this.changeScreenHandler, this._formKey);
  String _name, _surname, _email, _password_first, _password_second;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          padding: EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration:
                      _textFieldDecoration("Name", context, Icon(Icons.person)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onSaved: (input) => _name = input,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: _textFieldDecoration(
                      "Surname", context, Icon(Icons.person_outline)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onSaved: (input) => _surname = input,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: _textFieldDecoration(
                      "E-Mail", context, Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: _textFieldDecoration(
                      "Password", context, Icon(Icons.lock)),
                  obscureText: true,
                  onSaved: (input) => _password_first = input,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: _textFieldDecoration(
                      "Confirm password", context, Icon(Icons.lock_outline)),
                  obscureText: true,
                  onSaved: (input) => _password_second = input,
                  validator: (value) {
                    _formKey.currentState.save();
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    } else if (value != _password_first) {
                      print(_password_first);
                      return "First and second password do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .pushReplacementNamed(LoginScreen.routeName);
                    signUpTheUser(context);
                  },
                  child: Text("SignUp"),
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
                  child: Text("Login instead"),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3)),
                ),
              ],
            ),
          )),
    );
  }

  void signUpTheUser(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthenticationManipulator.signUpUser(
          context, _email, _name, _surname, _password_second);
    }
  }

  void checkFormParameters(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool canGo = true;
      print(_email);
      //check email
      if (_email.isEmpty) {
        canGo = false;
      }
      if (_name.isEmpty) {
        canGo = false;
      }

      if (_surname.isEmpty) {
        canGo = false;
      }
      if (_password_first.isEmpty) {
        canGo = false;
      }
      if (_password_second.isEmpty) {
        canGo = false;
      }
      if (!(_password_first == _password_second)) {
        canGo = false;
      }

      if (canGo) {
        signUpTheUser(context);
      }
    }
  }
}
