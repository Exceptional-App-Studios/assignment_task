import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
var androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
var iOSInit = IOSInitializationSettings();
var init = InitializationSettings(android: androidInit, iOS: iOSInit);

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';

  @override
  _TaskSevenState createState() => _TaskSevenState();
}

class _TaskSevenState extends State<TaskSeven> {
  Future<void> showNotification() async {
    await notifications.show(
        0,
        'Notification',
        'This is a test notification',
        NotificationDetails(
          android: AndroidNotificationDetails(
              "id", "Notification", "This is a test notification",),
          iOS: IOSNotificationDetails(),
        ),
        payload: 'payload');
  }

  @override
  void initState() {
    notifications.initialize(init);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Task 7: Send Dummy Notification
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: showNotification,
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Send Notification',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Click the button to send a basic notification')
          ],
        ),
      ),
    );
  }
}
