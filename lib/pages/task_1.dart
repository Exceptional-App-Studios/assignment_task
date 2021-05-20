import 'dart:convert';

import 'package:assignment_app/models/json_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;


class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {

  String  userName = "Name";
  String successMessage = "Success Message";
  String image;
  bool onP = false;
  UserData futureData;
  Future<UserData> fetchData() async {
    final response =
    await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/1'));
    if (response.statusCode == 200) {
      UserData data = UserData.fromJson(jsonDecode(response.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, (Question: if this is used what should you remove from the code?)
            // Answer : We can remove Spacer() to use the above given.
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: onP?NetworkImage(image):null,
              ),

              SizedBox(height: 15), //Image from API
              Text(
                userName,
                style: TextStyle(
                    fontSize: 29,
                    color: Colors.black
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
                    primary: HexColor('#363636'),
                  ),
                  onPressed: () async {
                    futureData = await fetchData();
                    userName = futureData.name;
                    image = futureData.image_url;
                    //print(futureData);
                    onP = true;
                    if(futureData!=null) {
                      successMessage = "Name successfully fetched from API";
                    }else{
                      successMessage = "Error occurred";
                    }
                    setState(() {});
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
                child: Text(
                  successMessage,
                  style: TextStyle(
                    fontSize: 18,
                    color: HexColor('#009154'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

