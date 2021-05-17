import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}

// I have solved this task using the package: flutter_local_notifications to send a simple notification to the user.

class _TaskSevenState extends State<TaskSeven> {
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        );
  }

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              AspectRatio(aspectRatio: 1,
                child: ElevatedButton(
                  onPressed: showNotification,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: HexColor('#009154'),
                  ),
                  child: Text('Send Notification',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text('Click this Button to send a Basic Notification',textAlign: TextAlign.center,
               style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w300),
               )
            ],
          ),
        ),
      ),
    );
  }

     
  showNotification() async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android,iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter Assignment App', 'Basic Notification', platform,
        payload: 'Welcome to Notification');
  }
  
}
