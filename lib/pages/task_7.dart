import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}
// Task 7: Send Dummy Notification

class _TaskSevenState extends State<TaskSeven> {
  FlutterLocalNotificationsPlugin flutterNOtification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('appstore');
    var iosInitialize = new IOSInitializationSettings();
    var initilizationSetting = new InitializationSettings(
        android: androidInitilize, iOS: iosInitialize);
    flutterNOtification = new FlutterLocalNotificationsPlugin();
    flutterNOtification.initialize(initilizationSetting,
        onSelectNotification: notificationSelected);
  }

  @override
  Widget build(BuildContext context) {
    Future _showNotification() async {
      var androidNotification =
          new AndroidNotificationDetails('channelID', "harbansi", 'Student');
      var iosdetails = new IOSNotificationDetails();
      var generalNotification = new NotificationDetails(
          android: androidNotification, iOS: iosdetails);

      await flutterNOtification.show(
          0, 'task7', 'Successfully Completed Task!!', generalNotification);
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
