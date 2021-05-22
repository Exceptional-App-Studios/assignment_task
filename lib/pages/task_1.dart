import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  Widget picture = CircleAvatar(
    radius: 70,
  );
  String message = '';
  Map mapResponse = {};
  String name = '';

  Future fetchData() async {
    http.Response response = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/26'));
    if (response.statusCode == 200) {
      setState(() {
        message = 'Name successfully fetched from api';
        mapResponse = jsonDecode(response.body);
        name = mapResponse['name'];

        picture = CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(mapResponse['image_url'].toString()),
        );
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //Answer: Spacer() should be removed. (Question: if this is used what should you remove from the code?)
                children: [
                  Column(
                    children: [
                      picture,
                      SizedBox(height: 15.0,),
                      Text(
                        name,
                        style: TextStyle(fontSize: 29, color: Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    children: [
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
                          onPressed: () {
                            fetchData();
                          },
                          child: Text(
                            'Load data from api',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
