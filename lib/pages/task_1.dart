import 'package:assignment_app/models/user_model.dart';
import 'package:assignment_app/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  
  Future<UserModel> _userModel;
  String image,name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              SizedBox(height: 20),
              image != null ? 
              CircleAvatar(
                backgroundImage: NetworkImage('$image'),
                radius: 70,
              ) : 
              CircleAvatar(
                radius: 70,
              ),
              SizedBox(height: 15), //Image from API
              Text(
                name,
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
                  onPressed: () {
                    setState(() {
                      if(_userModel == null){
                        _userModel = UserApi().getUser();
                        _userModel.then((value){ 
                          image = value.imageUrl; 
                          name = value.name;
                        });
                      }
                      // print(image);
                    });
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
                  name != "" ? 'Name Successfully fetch from API' : '',
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
