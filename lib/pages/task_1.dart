import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

// I have done this task by using the http package to get data from the API in a function and calling it on button click.
// and used try catch and statuscode to check if there was any issue in loading the data.
 
 class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  String message = '',name='Name';
  bool success = false;
  var data;
  var response;
  fetchData() async {
    try{
      response = await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/5'));

       if (response.statusCode == 200) {
      print('Success');
      data = jsonDecode(response.body);
      message = 'Successfully Fetched from API!';
      success=true;
      setState(() {
      });
    } else {
      message = 'Fetching data unsuccessful!';
      success=false;
       setState(() {
      });
      print(response.statusCode);
      print('Failed');
    }
    }
    catch(e){
      print("Some error occured: "+e.toString());
       message = 'Fetching data unsuccessful!';
      success=false;
       setState(() {
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
             //mainAxisAlignment: MainAxisAlignment.spaceBetween, 
             //(Question: if this is used what should you remove from the code?)
             // Answer: we can remove spacer from the code if this is used, since spacer takes up all the available space it can get.
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: success?NetworkImage(data['image_url']):null,
              ),
              SizedBox(height: 15), //Image from API
              Text(
                success?data['name']:'Name',
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
                  onPressed: fetchData,
                  child: Text(
                    'Load data from api',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: HexColor('#009154'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
