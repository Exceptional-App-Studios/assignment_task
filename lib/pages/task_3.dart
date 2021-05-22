import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {

  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
     return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: SingleChildScrollView(
                          child: Column(
                children: [
                  // name
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter your name";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Type Your Name here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 40.0),
                  //  Email
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter your Email";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Type Your Email here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 40.0),
                  // collegeId
                  TextFormField(
                    controller: idController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter your collegeId";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: "CollegeId",
                        hintText: "Type your CollegeId here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 90.0),

                  Container(
                    height: 70,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 5,
                        primary: HexColor('#009154'),
                      ),
                      onPressed: 
                        postdata,
                      
                      child: Text(
                        'Post Data to api',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
   postdata() async {
    print(_formkey.currentState.validate());
    if (!_formkey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Data'),
        duration: Duration(seconds: 1),
      ));
    } else {
      try {
         await http.post(
          Uri.parse('https://exceptional-studios.herokuapp.com/api/users/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'name': nameController.text,
            'email': emailController.text,
            'collegeId': idController.text,
          }),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Post Successful!!'),
          duration: Duration(seconds: 1),
        ));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Some error occured!'),
          duration: Duration(seconds: 1),
        ));
      }
    }
  }
}
