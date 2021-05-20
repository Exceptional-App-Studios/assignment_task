import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  Future<FetchData> data;

  Future<FetchData> getdata(String name, String email, String collegeId) async {
    final response = await http.post(
      Uri.https('exceptional-studios.herokuapp.com', 'api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "collegeId": collegeId,
      }),
    );

    if (response.statusCode == 201) {
      return FetchData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: (data == null)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "Full name",
                            labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                            hintText: "Type your name here",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                          controller: nameController,
                        ),
                        SizedBox(height: 25),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                            hintText: "Type your email here",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: "College ID",
                            labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                            hintText: "Type your password here",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                          controller: cidController,
                        ),
                        Spacer(),
                        Container(
                          width: 219,
                          height: 60,
                          margin: EdgeInsets.only(bottom: 50),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              elevation: 10,
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                data = getdata(nameController.text,
                                    emailController.text, cidController.text);
                              });
                            },
                            child: Text(
                              'Post data to api',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : FutureBuilder<FetchData>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            SizedBox(height: 100),
                            Text("Name: ${snapshot.data.name}",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text("email: ${snapshot.data.email}",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text("college ID : ${snapshot.data.collegeId}",
                                style: TextStyle(
                                  fontSize: 20,
                                ))
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return CircularProgressIndicator();
                    },
                  )));
  }
}

class FetchData {
  String name;
  String email;
  String collegeId;
  FetchData({this.name, this.collegeId, this.email});

  factory FetchData.fromJson(Map<String, dynamic> dataitem) {
    return FetchData(
        name: dataitem['name'],
        email: dataitem['email'],
        collegeId: dataitem['collegeId']);
  }
}
