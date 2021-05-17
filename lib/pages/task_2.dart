import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
String message = '';
bool success = false;
bool loading = false;
  var data;
  var response;
  fetchlistdata() async {
    try{
      setState(() {
      loading=true;
      });
      response = await http.get(Uri.https('exceptional-studios.herokuapp.com', 'api/users/'));
       if (response.statusCode == 200) {
      print('Success');
      data = jsonDecode(response.body);
      loading=false;
      message = 'List successfully fetched from API!';
      success=true;
      setState(() {
      });
    } else {
      message = 'Fetching list unsuccessful!';
      loading=false;
      success=false;
       setState(() {
      });
      print(response.statusCode);
      print('Failed');
    }
    }
    catch(e){
      loading=false;
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
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(
              child: loading?Center(child: CircularProgressIndicator()):ListView.builder(
                itemCount: success?data.length:0,
                itemBuilder: (context, index){
                return Container(
                  color: Colors.lightBlue.shade50,
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical:10),
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical:8),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data[index]['name'],
                      style: TextStyle(color: Colors.blueGrey,fontSize:18),
                      ),
                      CircleAvatar(
                        radius: 26,
                        backgroundColor:Colors.blueGrey.shade400,
                        child: CircleAvatar(
                        backgroundColor:Colors.lightBlueAccent,
                          radius: 24,
                         backgroundImage: success?NetworkImage(data[index]['image_url']):null,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
      
           SizedBox(height: 20,),
            Container(
                  width: 219,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 8,
                      primary: HexColor('#363636'),
                    ),
                    onPressed: fetchlistdata,
                    child: Text(
                      'Load List from api',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#009154'),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
