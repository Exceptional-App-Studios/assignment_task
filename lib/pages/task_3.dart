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
  TextEditingController FullnameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController CollageidController = TextEditingController();
  bool check=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Form'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: FullnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type your Name here',
                          labelText: "Full Name"
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: EmailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type your Email here',
                          labelText: "Email"
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: CollageidController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Type your Clg id here',
                          labelText: "Colleage ID"
                        ),
                      ),
                    ),
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
                    onPressed: send,
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
                child: check ? Text(
                  'Successfully Post data',
                  style: TextStyle(
                    fontSize: 18,
                    color: HexColor('#009154'),
                  ),
                ): null,
              ),
            ],
          ),
        )
    );
  }
  void send() async{

    final reponse = await http.post(Uri.parse('https://firebasestorage.googleapis.com/v0/b/fire-1ce9b.appspot.com/o/Dhruv1.Json?alt=media&token=e9f72812-4bf7-4737-afcb-6f0701f9ddda'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body:  jsonEncode(<String,String>{
        "Full Name" : FullnameController.text,
        "Email" : EmailController.text,
        "ID" : CollageidController.text
      }),
    );
    print(reponse.statusCode);
    if(reponse.statusCode == 200){
      setState(() {
        check = true;
      });
      FullnameController.clear();
      EmailController.clear();
      CollageidController.clear();
    }
  }
}
