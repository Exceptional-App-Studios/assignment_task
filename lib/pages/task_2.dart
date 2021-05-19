import 'package:assignment_app/models/user.dart';
import 'package:assignment_app/models/userapi.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    //Hint: You can use ListView/Listview.builder() to do this.
    return Scaffold(
        body: Column(
          children: [
            Container(
              child: FutureBuilder<List<user>>(
                future: userapi.userList(),
                builder: (context, snapshot) {
                  final users = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Center(child: Text('Something Happend Wrong!'));
                      } else {
                        return check
                            ? buildUsers(users)
                            : Center(
                          child: Container(
                            child: Text("Load list from api"),
                          ),
                        );
                      }
                  }
                },
              ),
              height: 550,
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
                  setState(() {
                    check = true;
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
              child: check ? Text(
                'Load list from api',
                style: TextStyle(
                  fontSize: 18,
                  color: HexColor('#009154'),
                ),
              ): null,
            )
          ],
        ));
  }

  Widget buildUsers(List<user> users) => ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: users.length,
    itemBuilder: (context, index) {
      final user = users[index];

      return Card(
        child: ListTile(
          title: Text(user.Firstname),
          subtitle: Text(user.Email),
          trailing: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black87,
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(user.Image),
            ),
          ),
        ),
        color: Colors.grey[300],
      );
    },
  );
}
