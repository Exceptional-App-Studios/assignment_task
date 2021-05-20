import 'package:flutter/material.dart';

class Task5 extends StatefulWidget {
  static const routeName = 'task-five';
  @override
  _Task5State createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  @override
  Widget build(BuildContext context) {
    //Task 5: Showing Graph
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Text("Show a linear graph Of you choice here"),
              ),
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
                  'data from API',
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
                  'Show local data',
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
