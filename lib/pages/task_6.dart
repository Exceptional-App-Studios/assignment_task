import 'package:flutter/material.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';
  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
  TextEditingController _notecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Task 6: Fetch Data from localdb.
    return Scaffold(
      body: Column(
        children: [
          Container(),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _notecontroller,
                    decoration: InputDecoration(
                        labelText: "Note",
                        hintText: "Type a note here",
                        border: OutlineInputBorder()),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: Colors.green,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Save Data',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }
}
