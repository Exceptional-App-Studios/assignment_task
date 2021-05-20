import 'package:assignment_app/pages/task_1.dart';
import 'package:assignment_app/pages/task_2.dart';
import 'package:assignment_app/pages/task_3.dart';
import 'package:assignment_app/pages/task_4.dart';
import 'package:assignment_app/pages/task_5.dart';
import 'package:assignment_app/pages/task_6.dart';
import 'package:assignment_app/pages/task_7.dart';
import 'package:assignment_app/tasks.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskList(),
      routes: {
        TaskOne.routeName: (context) => TaskOne(), //Load Data From Api
        TaskTwo.routeName: (context) => TaskTwo(), //Load List From api
        TaskThree.routeName: (context) => TaskThree(), // Post Data from api
        TaskFour.routeName: (context) => TaskFour(), //Play Audio
        Task5.routeName: (context) => Task5(), // Graph
        TaskSix.routeName: (context) => TaskSix(), //Local db
        TaskSeven.routeName: (context) => TaskSeven(), //Send Notification
      },
    );
  }
}