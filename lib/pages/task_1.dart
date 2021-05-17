import 'package:assignment_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskOne extends StatefulWidget {
  static const routeName = 'task-one';
  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  get ss => setState(() {});
  var data = {'name': '', 'image': ''};
  bool dataLoaded = false;
  bool isLoading = false;
  String error = '';
  final api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //? Question: if this is used what should you remove from the code?
            //* Answer: We may remove Spacer(), but then the layout will also change.
            children: [
              SizedBox(height: 20),
              (data['image'].isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        data['image'],
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircleAvatar(radius: 70),
              SizedBox(height: 15), //Image from API
              Text(
                data['name'].isNotEmpty ? data['name'] : 'Name',
                style: TextStyle(fontSize: 29, color: Colors.black),
              ),
              Spacer(),
              Container(
                width: 219,
                height: 60,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          primary: HexColor('#363636'),
                        ),
                        onPressed: () async {
                          isLoading = true;
                          ss;
                          try {
                            // final result = await api.getTask1Details();
                            // final fullName =
                            //     "${result['name']['title']} ${result['name']['first']} ${result['name']['last']}";
                            // final imageUrl = result['picture']['large'];
                            final result = await api.getUser();
                            dataLoaded = true;
                            data['name'] = result['name'];
                            data['image'] = result['image_url'];
                          } catch (e) {
                            error = e.toString();
                          }
                          isLoading = false;
                          ss;
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
                child: data['name'].isNotEmpty && dataLoaded
                    ? Text(
                        'Data loaded successfully',
                        style: TextStyle(
                          fontSize: 18,
                          color: HexColor('#009154'),
                        ),
                      )
                    : dataLoaded
                        ? Text(
                            'Some error occurred $error',
                            style: TextStyle(
                              fontSize: 18,
                              color: HexColor('#ff0000'),
                            ),
                          )
                        : Text(
                            'Tap on the button to load data',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlue,
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
