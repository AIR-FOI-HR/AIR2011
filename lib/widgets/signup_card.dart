import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../screens/view_orders_screen.dart';

class SignupCard extends StatelessWidget {
  final Function changeScreenHandler;
  SignupCard(this.changeScreenHandler);

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
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Surname"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "E-Mail"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirm password"),
                  obscureText: true,
                  onSaved: null,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
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
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
              ],
            ),
          )),
    );
  }
}
