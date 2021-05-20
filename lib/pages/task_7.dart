import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin notifications =
FlutterLocalNotificationsPlugin();

class TaskSeven extends StatefulWidget {
  static const routeName = 'task-seven';
  @override
  _TaskSevenState createState() => _TaskSevenState();
}

class _TaskSevenState extends State<TaskSeven> {

  @override
  void initState(){
    initSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Task 7: Send Dummy Notification
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width-40,
                height: MediaQuery.of(context).size.width-40,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: ()  {
                    displayNotification();
                  },
                  child: Text("Send Notification",style: TextStyle(fontSize: 20),),
                ),
              ),
              SizedBox(height: 20,),
              Text("Click this button to send a ",
                style: TextStyle(color: Colors.grey,fontSize: 20,),
              ),
              Text("basic notification",
                style: TextStyle(color: Colors.grey,fontSize: 20,),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> displayNotification() async {
    notifications.show(0, "Notification", "Dummy notification", NotificationDetails(android: AndroidNotificationDetails("channelID","chanelName","channelDes")));
  }

  void initSetting() async{
    var androidInit = AndroidInitializationSettings('photo');
    var iOSInit = IOSInitializationSettings();
    var init = InitializationSettings(android: androidInit, iOS: iOSInit);
    await notifications.initialize(init);
  }
}
