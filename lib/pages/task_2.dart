import 'dart:convert';

import 'package:assignment_app/models/json_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;


class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {

  String successMessage = "Success Message";
  List<UserData> futureData;
  bool onP = false;

  Future<List<UserData>> fetchData() async {
    final response = await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/users'));

    if (response.statusCode == 200) {
      var dataObjJson = jsonDecode(response.body) as List;
      List<UserData> data = dataObjJson.map((tagJson) => UserData.fromJson(tagJson)).toList();
      print(data);
      return data;

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Hint: You can use ListView/Listview.builder() to do this.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.width-20,
                  child: onP? getListView() : Container(color: Colors.grey[200],),
                ),
                //Spacer(),
                SizedBox(height: 20,),
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
                      // userName = futureData.first_name + " " + futureData.last_name;
                      // image = futureData.avatar;
                      //print(futureData);
                      onP = true;
                      if(futureData!=null) {
                        successMessage = "List successfully fetched from API";
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
      ),
    );
  }

  Widget getListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: futureData.length,
      itemBuilder: (BuildContext context,int index) {
        return onP ? Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),              color: Colors.grey[200],
              ),
              height: 50,
              width: MediaQuery.of(context).size.width-20,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Text(futureData[index].name),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage: NetworkImage(futureData[index].image_url),
                  ),
                  SizedBox(width: 10,),

                ],
              ),
            ),
          ),
        ) : Container();
      },
    );
  }
}
