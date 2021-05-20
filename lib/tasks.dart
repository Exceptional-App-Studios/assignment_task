import 'package:assignment_app/models/task_list.dart';
import 'package:assignment_app/pages/task_1.dart';
import 'package:assignment_app/pages/task_2.dart';
import 'package:assignment_app/pages/task_3.dart';
import 'package:assignment_app/pages/task_4.dart';
import 'package:assignment_app/pages/task_5.dart';
import 'package:assignment_app/pages/task_6.dart';
import 'package:assignment_app/pages/task_7.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TaskInfo> allTasks = [
      TaskInfo('Task 1', 'Fetching Data from api', HexColor('#EF4900'),
          TaskOne.routeName),
      TaskInfo('Task 2', 'Working with List View', HexColor('#363636'),
          TaskTwo.routeName),
      TaskInfo('Task 3', 'Post data to api', HexColor('#E3B800'),
          TaskThree.routeName),
      TaskInfo('Task 4', 'Working with audio', HexColor('#6E53FF'),
          TaskFour.routeName),
      TaskInfo('Task 5', 'Working with graphs', HexColor('#00B267'),
          Task5.routeName),
      TaskInfo('Task 6', 'Save Data Locally', HexColor('#C60054'),
          TaskSix.routeName),
      TaskInfo('Task 7', 'Show Notifications', HexColor('#ED00B6'),
          TaskSeven.routeName),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Task List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: allTasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(allTasks[index].routeNames);
                    },
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      width: double.infinity,
                      color: allTasks[index].cardColor,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allTasks[index].taskName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  allTasks[index].taskName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}