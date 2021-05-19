import 'dart:math';

import 'package:assignment_app/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:assignment_app/Api/api_call.dart';

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  String image, name;
  bool check = false;
  UserInfo data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, (Question: if this is used what should you remove from the code?)
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: image != null ? NetworkImage(image) : null,
              ),
              SizedBox(height: 15), //Image from API
              Text(
                name != null ? name : "Name",
                style: TextStyle(fontSize: 29, color: Colors.black),
              ),
              Spacer(),
              Container(
                width: 219,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    elevation: 10,
                    primary: HexColor('#363636'),
                  ),
                  onPressed: () async {
                    data = await ApiCall.GetUserData(Random().nextInt(4));
                    displaydata();
                  },
                  child: Text(
                    'Load data from api',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: check
                    ? Text(
                        'Success Message',
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#009154'),
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  void displaydata() {
    setState(() {
      name = data.firstname.toString();
      image = data.image.toString();
      check = true;
    });
  }
}
