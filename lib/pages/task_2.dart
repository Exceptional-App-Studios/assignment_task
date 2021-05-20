import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  bool pressed = false;

  Future getdata() async {
    setState(() {
      pressed = true;
    });
    final response = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users'));
    //var responseData = json.decode(response.body);
    var responseData = jsonDecode(response.body);
    List<FetchData> userdata = [];
    for (var dataitem in responseData) {
      FetchData item = FetchData(
        name: dataitem['name'],
        imageUrl: dataitem['image_url'],
      );
      userdata.add(item);
    }
    print(userdata.length);
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pressed
          ? FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(
                                  bottom: 15,
                                  right: 25,
                                  left: 25,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Center(
                                      child: Text(snapshot.data[index].name,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      });
              })
          : Container(),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.13,
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
                onPressed: () {
                  getdata();
                },
                child: Text(
                  'Load list from API',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            pressed
                ? Text(
                    'List successfully fetched from API',
                    style: TextStyle(color: Colors.green, fontSize: 15),
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
}
