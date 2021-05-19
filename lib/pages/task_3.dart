import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:assignment_app/services/user_api.dart';
import 'package:assignment_app/models/post_model.dart';

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {

  bool flag = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController collegeIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(  
                    controller: nameController,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),  
                      labelText: 'Full name', 
                      hintText: 'Type your name here' 
                    ),  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(  
                    controller: emailController,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),  
                      labelText: 'Email', 
                      hintText: 'Type your email here' 
                    ),  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(  
                    controller: collegeIdController,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),  
                      labelText: 'College ID', 
                      hintText: 'Type your password here' 
                    ),  
                  ),
                ),
              ], //Hint: TextField can be used here. Change Column widget to necessary Widgets
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
                      primary: Colors.green,
                    ),
                    onPressed: () async {
                      final String name = nameController.text;
                      final String email = emailController.text;
                      final String collegeId = collegeIdController.text;
                      PostModel  user = await UserApi().createUser(name,email,collegeId);
                      if(user != null){
                        setState(() {
                          flag = true;
                        });
                      }
                      
                    },
                    child: Text(
                      'Post data to api',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    flag == true ? 'Post data successfully' : '',
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
    );
  }
}
