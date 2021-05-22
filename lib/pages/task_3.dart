import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Album> createAlbum(
    String fullName, String email, String collegeId) async {
  final response = await http.post(
    Uri.https('exceptional-studios.herokuapp.com', 'api/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': fullName,
      'email': email,
      'collegeId': collegeId,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final String fullName;
  final String email;
  final String collegeId;

  Album({required this.fullName, required this.email, required this.collegeId});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      fullName: json['name'],
      email: json['email'],
      collegeId: json['collegeId'],
    );
  }
}



class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _collegeIdController = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: (_futureAlbum == null)
              ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: buildColumn(),
          )
              : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _fullNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            labelText: 'Full name',
            hintText: 'Type your name here.',
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: _emailController,

          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            labelText: 'Email',
            hintText: 'Type your email here.',
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          controller: _collegeIdController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            labelText: 'College ID',
            hintText: 'Type your college ID here.',
          ),
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
              primary: Colors.green,
            ),
            onPressed: () {
              setState(() {
                _futureAlbum = createAlbum(_fullNameController.text,
                    _emailController.text, _collegeIdController.text);
              });
            },
            child: Text(
              'Post data to api',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Column(
              children: [
                Text(snapshot.data!.fullName),
                Text(snapshot.data!.collegeId),
                Text(snapshot.data!.email),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

}
