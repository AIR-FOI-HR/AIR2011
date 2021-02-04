import 'package:air_2011/db_managers/authentication.dart';
import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCard extends StatelessWidget {
  /*Function handler for changing between
    Login screen and Registration/Signup screen
  */
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

  FirebaseAuth auth = FirebaseAuth.instance;
  final Function changeScreenHandler;
  final GlobalKey<FormState> _formKey;
  LoginCard(this.changeScreenHandler, this._formKey);
  static String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                    onSaved: (input) => _email = input),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: _textFieldDecoration(
                      "Password", context, Icon(Icons.lock)),
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
                    //closes keyboard if not closed
                    FocusScope.of(context).unfocus();
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
                    changeScreenHandler("Registration");
                  },
                  child: Text("Signup instead"),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3)),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    changeScreenHandler("Forgotten");
                  },
                  child: Text("Reset password"),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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

  void forgotPassword(context) async {
    _formKey.currentState.save();
    print(_email);
    AuthenticationManipulator.forgotPassword(context, _email);
  }

  void tryAutoSignIn(context) async {
    bool userSignedIn = await AuthenticationManipulator.isUserLoggedIn();
    if (userSignedIn) {
      final prefs = await SharedPreferences.getInstance();
      _email = prefs.getString('userEmail');
      _password = prefs.getString('userPassword');
      AuthenticationManipulator.loginUser(context, _email, _password);
    }
  }
}
