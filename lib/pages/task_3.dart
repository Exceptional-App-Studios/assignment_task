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
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final id = TextEditingController();

  postdata() async {
    print(_formKey.currentState.validate());
    if (!_formKey.currentState.validate()) {
      print('Invalid Data');
    } else {
      try {
        var response = await http.post(
            Uri.parse('https://exceptional-studios.herokuapp.com/api/users/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'name': name.text,
            'email': email.text,
            'collegeId': id.text,
          }),
        );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post Successful!!'),duration: Duration(seconds: 1), ));

      } catch (e) {
        print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some error occured!'),duration: Duration(seconds: 1), ));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                  controller: name,
                  hintText: 'Type your name here',
                  labelText: 'Full Name',
                  type: TextInputType.name,
                  validate: (val) {
                    if (val.length == 0) {
                      return "Name cannot be empty!";
                    } else {
                      return null;
                    }
                  },
                ),
                InputTextField(
                  controller: email,
                  hintText: 'Type your email here',
                  labelText: 'Email',
                  type: TextInputType.emailAddress,
                  validate: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty!";
                    } else {
                      return null;
                    }
                  },
                ),
                InputTextField(
                  controller: id,
                  hintText: 'Type your college id here',
                  labelText: 'College ID',
                  type: TextInputType.text,
                  validate: (val) {
                    if (val.length == 0) {
                      return "ID cannot be empty!";
                    } else {
                      return null;
                    }
                  },
                ),
                Spacer(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 5,
                      primary: HexColor('#009154'),
                    ),
                    onPressed: postdata,
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
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.labelText,
    @required this.type,
    @required this.validate,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType type;
  final Function validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: new InputDecoration(
          hintText: hintText,
          labelText: labelText,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        validator: validate,
        keyboardType: type, //TextInputType.emailAddress,
      ),
    );
  }
}
