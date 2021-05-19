import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}

class _TaskSevenState extends State<TaskSeven> {

  FlutterLocalNotificationsPlugin localNotification;
  String task;
  int val;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
      new InitializationSettings(android : androidInitilize,iOS:  iOSinitilize);
      localNotification = new FlutterLocalNotificationsPlugin();
     localNotification.initialize(initilizationsSettings);
      // onSelectNotification: notificationSelected);
  }
      
        
  @override
  Widget build(BuildContext context) {
    //Task 7: Send Dummy Notification
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: MediaQuery.of(context).size.width*0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: _showNotification,
                  child: Text(
                    'Send Notification',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Click this button to send a basic notification",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId", 
      "Local Notification", 
      "channelDescription",
      importance: Importance.high
    );
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.show(0, "Notif Title",
      "The body of notif", generalNotificationDetails);
  }
}
