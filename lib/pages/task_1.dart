import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class User {
  final String name;
  final String imageUrl;
  final String email;
  User({this.name, this.imageUrl, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json["name"], imageUrl: json["image_url"], email: json['email']);
  }
}

class _TaskOneState extends State<TaskOne> {
  bool isPressed = false;
  Future getSingleUserData() async {
    setState(() {
      isPressed = true;
    });
    var responce = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/14'));
    if (responce.statusCode == 200) {
      final jsonData = jsonDecode(responce.body);

      User user = User(
        name: jsonData['name'],
        imageUrl: jsonData['image_url'],
        email: jsonData['email'],
      );
      print(user.name);
      print(user.imageUrl);
      print(user.email);
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isPressed
          ? SafeArea(
              child: Center(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getSingleUserData(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${snapshot.data.imageUrl}'),
                                    radius: 130,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data.name,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                    SizedBox(
                      height: 300,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'please Press below button for Loading Data from API.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 220,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 10,
                  primary: HexColor('#363636'),
                ),
                onPressed: getSingleUserData,
                child: Text(
                  'Load data from API',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: isPressed
                    ? Text(
                        'Name successfully fetch from API',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#009154'),
                        ),
                      )
                    : Text(''))
          ],
        ),
      ),
    );
  }
}
