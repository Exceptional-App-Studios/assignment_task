import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// This task is implemented by using http package to retrieve data from API in function and getting it on button click.
//And checked error in loading data using try catch as well as status code.

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
      response = await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/31'));

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
               // Answer: Spacer can be alternative to remove this from the code, as spacer takes all the available space.
            children: [
              SizedBox(height: 25),
              CircleAvatar(
                radius: 70,
                backgroundImage: success?NetworkImage(data['image_url']):null,
              ),
              SizedBox(height: 20), //Image from API
              Text(
                success?data['name']:'Name',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              Spacer(),
              Container(
                width: 210,
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


