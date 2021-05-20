import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:assignment_app/models/userModel.dart';
import 'package:http/http.dart' as http;

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

Future<UserModel> createuser(
    String name, String email, String collegeId) async {
  try {
    final responce = await http.post(
        Uri.https('exceptional-studios.herokuapp.com', 'api/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: {
          "name": name,
          "email": email,
          "collegeId": collegeId
        });

    if (responce.statusCode == 201) {
      final String responceString = responce.body;
      return userModelFromJson(responceString);
    } else {
      print(responce.statusCode.toString());
      throw Exception(
          'failed to load data with status code  ${responce.statusCode}');
    }
  } catch (e) {
    print(e);
    throw e;
  }
}

class _TaskThreeState extends State<TaskThree> {
  UserModel _user;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameContnroller = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController collegeIdController = TextEditingController();
    //Task 3: Posting Data to api
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: nameContnroller,
                decoration: InputDecoration(
                    hintText: 'Type your Name here',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Full Name',
                    focusColor: Colors.grey,
                    hoverColor: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'Type your Email Id here',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Email ',
                    focusColor: Colors.grey,
                    hoverColor: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: collegeIdController,
                decoration: InputDecoration(
                    hintText: 'Type your College ID here',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'College Id',
                    focusColor: Colors.grey,
                    hoverColor: Colors.grey),
              ),
              SizedBox(
                height: 350,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                height: 60.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
                child: TextButton(
                    onPressed: () async {
                      final name = nameContnroller.text;
                      final email = emailController.text;
                      final collegeId = collegeIdController.text;

                      UserModel userModel =
                          await createuser(name, email, collegeId);

                      setState(() {
                        _user = userModel;
                      });
                    },
                    child: Text(
                      'Post Data to API',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              _user == null
                  ? Container(
                      child: Text(''),
                    )
                  : Text(
                      'The User ${_user.name} has been created Successefully!!!'),
            ], //Hint: TextField can be used here. Change Column widget to necessary Widgets
          ),
        ),
      ),
    );
  }
}
