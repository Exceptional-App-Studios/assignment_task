import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}

class _TaskSevenState extends State<TaskSeven> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iOSinitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSinitialize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings);
  }

  _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "Murtaza", "to be at", "Exceptional Studios",
        importance: Importance.max);
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await fltrNotification.show(1, "Exceptional Studios", "Murtaza Bhaisaheb",
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    //Task 7: Send Dummy Notification
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: _showNotification,
            child: Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Send Notification',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
