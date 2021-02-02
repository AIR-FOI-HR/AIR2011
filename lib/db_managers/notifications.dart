import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

final String serverToken =
    'AAAABj_TiZ8:APA91bGE25eQr7iX6PgdgSXGIxUd8dCDmEYQb61GQA2_yBk7FSXc3qhubgv2v-iiE_tf5IZF7DTVENXhvuVwXE0zn0ZcWv4Uy6fqaPGwLqfyV4fcy8pBF7mhbkf2vBQcU9icuZeJek6T';
final navigatorKey = GlobalKey<NavigatorState>();

final FirebaseMessaging fbm = FirebaseMessaging();
void setUpNotificationSystem(BuildContext context) {
  fbm.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );

  fbm.getToken().then((String token) {
    assert(token != null);
    print("Push Messaging token: $token");
  });
}

Future sendNotification(String title, String body, String token) async {
  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': body, 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': token,
      },
    ),
  );
  //eph8TMAuRwWcZ8MYdeLytj:APA91bGjg5HVm67_ZtHlNz_WF4CV2PSQEgToi9ACtfA50i2n7GO3L8iOfGuk0mXE0zzo53djrmWLJpcpNTHFgNe-bPCnfXlq5l3v9C6bKRf3SmHbnhPwwyGU4QswSFPtv2YRjINFaE2w
}

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ListTile(
        title: Text('title'),
        subtitle: Text('body'),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  return Future<void>.value();
}
