import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  List listOfData = [];
  String message = '';

  Future fetchData() async {
    http.Response response = await http
        .get(Uri.https('exceptional-studios.herokuapp.com', 'api/users'));
    if (response.statusCode == 200) {
      setState(() {
        message = 'List successfully fetched from api';
        listOfData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    //Hint: You can use ListView/Listview.builder() to do this.
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listOfData.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0.0,
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text(
                        listOfData[index]['name'],
                      ),
                      trailing: CircleAvatar(
                        radius: 23.0,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                            listOfData[index]['image_url'],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                  'Load list from api',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
