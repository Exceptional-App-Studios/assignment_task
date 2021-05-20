import 'dart:convert';

import 'package:assignment_app/models/json_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {
  final _formKey = GlobalKey<FormState>();
  String successMessage = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _collegeIDController = TextEditingController();


  Future<UserData> createUser(String name,String email, String collegeId) async{
    final response = await http.post(
      Uri.https('exceptional-studios.herokuapp.com', 'api/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name':name,
        'email':email,
        'collegeId':collegeId,
      }),
    );

    if (response.statusCode == 201) {
      successMessage = "Data Sent Successfully";
      _nameController.text = "";
      _emailController.text = "";
      _collegeIDController.text = "";
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }


  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      hintText: "Type your name here",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Type your email here",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }else if(!value.contains("@")){
                        return "Enter valid Email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _collegeIDController,
                    decoration: InputDecoration(
                      labelText: "College ID",
                      hintText: "Type your College ID here",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "College ID cannot be empty";
                      }
                      return null;
                    },
                  ),
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
                      primary: Colors.green[700],
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        createUser(_nameController.text, _emailController.text, _collegeIDController.text);
                        setState(() {
                        });
                      }
                    },
                    child: Text(
                      'Post data to api',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    successMessage,
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#009154'),
                    ),
                  ),
                ),
                Spacer(),
              ], //Hint: TextField can be used here. Change Column widget to necessary Widgets
            ),
          ),
        ),
      ),
    );
  }
}
