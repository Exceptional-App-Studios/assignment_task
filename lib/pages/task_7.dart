import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}
// Task 7: Send Dummy Notification

class _TaskSevenState extends State<TaskSeven> {
  FlutterLocalNotificationsPlugin flutterNotification;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('appicon');
    var iosInitialize = new IOSInitializationSettings();
    var initilizationSetting = new InitializationSettings(
        android: androidInitilize, iOS: iosInitialize);
    flutterNotification = new FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initilizationSetting,
        onSelectNotification: notificationSelected);
  }

  @override
  Widget build(BuildContext context) {
    Future _showNotification() async {
      var androidNotification =
          new AndroidNotificationDetails('channelID', "Aditi", 'Desc');
      var iosdetails = new IOSNotificationDetails();
      var generalNotification = new NotificationDetails(
          android: androidNotification, iOS: iosdetails);

      await flutterNotification.show(
          0, 'Aditi patel', 'Hello!! new task is here', generalNotification);
    }

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(color: Colors.green),
                child: TextButton(
                  child: Text(
                    'Send Notification',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: _showNotification,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 100,
                width: 250,
                child: Text(
                  'Click this button to push the Notification!!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {}
}
