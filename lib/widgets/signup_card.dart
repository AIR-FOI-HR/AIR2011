import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/providers/app_user.dart';
import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/view_orders_screen.dart';

class SignupCard extends StatelessWidget {
  final Function changeScreenHandler;
  final GlobalKey<FormState> _formKey;
  SignupCard(this.changeScreenHandler, this._formKey);
  String _name, _surname, _email, _password_first, _password_second;

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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Surname"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onSaved: (input) => _surname = input,
                  
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "E-Mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  onSaved: (input) => _email = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: (input) => _password_first = input,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7 ) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirm password"),
                  obscureText: true,
                  onSaved: (input) => _password_second = input,
                  validator: (value) {
                    _formKey.currentState.save();
                    if (value.isEmpty || value.length < 7 ) {
                      return 'Password must be at least 7 characters long.';
                    }else if(value != _password_first){
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
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    changeScreenHandler();
                  },
                  child: Text("Login instead"),
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

  void signUpTheUser(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthenticationManipulator.signUpUser(context, _email,_name, _surname, _password_second);
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
