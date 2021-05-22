import 'package:assignment_app/models/user.dart';
import 'package:assignment_app/service/service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  ApiService apiService = ApiService();
  String image, name;
  bool check = false;
  User data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  (Question: if this is used what should you remove from the code?)
            // we can use  mainAxisAlignment: MainAxisAlignment.spaceBetween, instead of spacer
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: image != null ? NetworkImage(image) : null,
              ),
              SizedBox(height: 15), //Image from API
              Text(
                name != null ? name : "Name",
                style: TextStyle(fontSize: 29, color: Colors.black),
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
                  onPressed: () async {
                    data = await apiService.getUser();
                    displaydata();
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
                  child: check
                      ? Text(
                          'Success Message',
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('#009154'),
                          ),
                        )
                      : null)
            ],
          ),
        ),
      ),
    );
  }

  void displaydata() {
    setState(() {
      name = data.name.toString();
      image = data.url.toString();
      check = true;
    });
  }
}
