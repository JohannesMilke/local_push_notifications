import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projectname33/local_notications_helper.dart';
import 'package:projectname33/page/second_page.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            title('Basics'),
            RaisedButton(
              child: Text('Show notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'Tite', body: 'Body'),
            ),
            RaisedButton(
              child: Text('Replace notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'ReplacedTitle', body: 'ReplacedBody'),
            ),
            RaisedButton(
              child: Text('Other notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'OtherTitle', body: 'OtherBody', id: 20),
            ),
            const SizedBox(height: 32),
            title('Feautures'),
            RaisedButton(
              child: Text('Silent notification'),
              onPressed: () => showSilentNotification(notifications,
                  title: 'SilentTitle', body: 'SilentBody', id: 30),
            ),
            const SizedBox(height: 32),
            title('Cancel'),
            RaisedButton(
              child: Text('Cancel all notification'),
              onPressed: notifications.cancelAll,
            ),
          ],
        ),
      );

  Widget title(String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      );
}
