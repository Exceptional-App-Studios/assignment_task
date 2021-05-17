import 'package:assignment_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  get ss => setState(() {});
  var data = [];
  bool dataLoaded = false;
  bool isLoading = false;
  String error = '';
  final api = ApiService();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: height * 0.6,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final result = data[index];
                      final fullName = result['name'];
                      final imageUrl = result['image_url'];

                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                        color: Colors.grey[350],
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(fullName),
                            trailing: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                  color: Colors.grey[700],
                                  width: 2.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
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
                              // data = await api.getTask2Details();
                              data = await api.getUsers();
                              dataLoaded = true;
                              ss;
                            } catch (e) {
                              error = e.toString();
                              ss;
                              print(e);
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
                  child: data.isNotEmpty && dataLoaded
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
      ),
    );
  }
}
