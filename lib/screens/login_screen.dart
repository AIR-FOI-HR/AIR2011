import 'package:air_2011/screens/view_orders_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Form(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text("Admin"),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text("Buyer"),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "E-Mail"),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: null,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              obscureText: true,
                              onSaved: null,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    ViewOrdersScreen.routeName);
                              },
                              child: Text("Login"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              child: Text("Signup"),
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
