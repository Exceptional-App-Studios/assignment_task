import 'package:flutter/material.dart';

class TaskFour extends StatefulWidget {
  static const routeName = 'task-4';
  @override
  _TaskFourState createState() => _TaskFourState();
}

class _TaskFourState extends State<TaskFour> {
  @override
  Widget build(BuildContext context) {
    //Task 4: Playing Local Audio and Download Audio.
    //Hint: You can use audioplayer packages provided by flutter.
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Tap here to stop audio."),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 60.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Download & play',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black87,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Play local audio',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
