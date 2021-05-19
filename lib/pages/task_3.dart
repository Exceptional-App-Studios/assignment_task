import 'dart:convert';

import 'package:assignment_app/models/form_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {
  bool check = false;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _idcontroller = TextEditingController();
  ModelData _data = ModelData();
  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                      labelText: "Full name",
                      hintText: "Type your name here",
                      border: OutlineInputBorder()),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                TextField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Type your email here",
                      border: OutlineInputBorder()),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                TextField(
                    controller: _idcontroller,
                    decoration: InputDecoration(
                      labelText: "College ID",
                      hintText: "Type your password here",
                      border: OutlineInputBorder(),
                    )),
              ],
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 219,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 10,
                  primary: Colors.green,
                ),
                onPressed: senddata,
                child: Text(
                  'Post data To api',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: check
                ? Text(
                    'Data Added Successfully',
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#009154'),
                    ),
                  )
                : null,
          )
        ], //Hint: TextField can be used here. Change Column widget to necessary Widgets
      ),
    ));
  }

  void senddata() async {
    _data = ModelData(
        Name: _namecontroller.text,
        Email: _emailcontroller.text,
        ID: _idcontroller.text);

    final response = await http.post(
        Uri.parse(
            'https://firebasestorage.googleapis.com/v0/b/mystical-glass-250612.appspot.com/o/postdata.json?alt=media&token=48dd4c38-326b-4364-822a-3134c45b3ecf'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: json.encode(_data.toJson()));
    if (response.statusCode == 200) {
      setState(() {
        check = true;
        _namecontroller.clear();
        _emailcontroller.clear();
        _idcontroller.clear();
      });
    }
  }
}
