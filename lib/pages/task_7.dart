import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}

class _TaskSevenState extends State<TaskSeven> {
  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    localNotification = FlutterLocalNotificationsPlugin();
    var androidIntialize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosIntialize = new IOSInitializationSettings();
    var intializationSettings = new InitializationSettings(
        android: androidIntialize, iOS: iosIntialize);

    localNotification.initialize(intializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Notification'),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Task 7: Send Dummy Notification
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: showNotificaton,
              child: Container(
                height: 280,
                width: 280,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Send Notification',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Click this button to send a \n basic notification',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  showNotificaton() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification", "Example of Notification",
        priority: Priority.high, importance: Importance.max);
    var iosDetails = new IOSNotificationDetails();
    var generalNotification =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, "Example Notification",
        "The body of Example Notification", generalNotification,
        payload: "Hello Flutter Lovers !!");
  }
}
