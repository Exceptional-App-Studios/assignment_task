import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class User {
  final String name;
  final String imageUrl;
  User({this.name, this.imageUrl});
}

class _TaskTwoState extends State<TaskTwo> {
  bool pressed = false;
  Future getUserData() async {
    setState(() {
      pressed = true;
    });
    var responce = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users'));
    if (responce.statusCode == 200) {
      var jsonData = jsonDecode(responce.body);

      List<User> users = [];

      for (var u in jsonData) {
        User user = User(name: u['name'], imageUrl: u['image_url']);
        users.add(user);
      }
      print(users.length);
      return users;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User data'),
      ),
      body: pressed
          ? Container(
              child: Card(
                child: FutureBuilder(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.09,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 35),
                                child: Row(
                                  children: [
                                    Text("${snapshot.data[index].name}"),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundColor: Colors.grey[800],
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            snapshot.data[index].imageUrl),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  },
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'Please click the button to Fetch the data from API',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 60.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black87,
              ),
              child: TextButton(
                onPressed: () {
                  getUserData();
                },
                child: Text(
                  'Post Data to API',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            pressed
                ? Text(
                    'List successfully fetched from API',
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}
