import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  Future<FetchData> data;
  bool pressed = false;

  Future<FetchData> getdata() async {
    setState(() {
      pressed = true;
    });
    final response = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/12'));
    if (response.statusCode == 200) {
      return FetchData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unable to fetch data from the REST API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pressed
          ? FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //(Question: if this is used what should you remove from the code?)
                      //SizedBox()
                      children: [
                        SizedBox(height: 30),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(snapshot.data.imageUrl),
                        ),
                        SizedBox(height: 15),
                        Text(
                          snapshot.data.name,
                          style: TextStyle(fontSize: 29, color: Colors.black),
                        ),
                      ],
                    ),
                  );
              })
          : Container(),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 60.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black87,
              ),
              child: TextButton(
                onPressed: getdata,
                child: Text(
                  'Load data from api',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            pressed
                ? Text(
                    'Name successfully fetched from API',
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  )
                : Text('')
          ],
        ),
      ),
    );
  }
}

class FetchData {
  String name;
  String imageUrl;

  FetchData({this.name, this.imageUrl});

  factory FetchData.fromJson(Map<String, dynamic> dataitem) {
    return FetchData(
      name: dataitem['name'],
      imageUrl: dataitem['image_url'],
    );
  }
}
