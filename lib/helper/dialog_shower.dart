import 'package:air_2011/screens/login_screen.dart';
import 'package:flutter/material.dart';

class DialogShower {
  static void showDialogBox(
      String title, String content, context, String routeName) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => routeName != null
                  ? Navigator.of(context).pushReplacementNamed(routeName)
                  : Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
