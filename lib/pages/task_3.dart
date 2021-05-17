import 'package:assignment_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TaskThree extends StatefulWidget {
  static const routeName = 'task-three';
  @override
  _TaskThreeState createState() => _TaskThreeState();
}

class _TaskThreeState extends State<TaskThree> {
  get ss => setState(() {});
  bool dataUploaded = false;
  bool isLoading = false;
  String error = '';
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final api = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Task 3: Posting Data to api
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Type your name here',
                      labelText: 'Full name',
                    ),
                    validator: (value) => value.length >= 3
                        ? null
                        : 'Enter at least 3 characters',
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Type your email here',
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        value.contains('@') ? null : 'Enter a valid email',
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Type your ID here',
                      labelText: 'College ID',
                    ),
                    validator: (value) => value.length >= 3
                        ? null
                        : 'Enter at least 3 characters',
                    controller: idController,
                  ),
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
                            primary: Colors.green,
                          ),
                          onPressed: () async {
                            isLoading = true;
                            ss;
                            if (formKey.currentState.validate()) {
                              try {
                                dataUploaded = await api.createUser(
                                    nameController.text,
                                    emailController.text,
                                    idController.text);
                                nameController.clear();
                                emailController.clear();
                                idController.clear();
                              } catch (e) {
                                error = e.toString();
                                print(e);
                              }
                            } else
                              print('enter valid details');
                            final snackBar =
                                SnackBar(content: Text('Successfully posted!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            isLoading = false;
                            ss;
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
                  child: dataUploaded
                      ? Text(
                          'Data uploaded successfully',
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('#009154'),
                          ),
                        )
                      : Text(
                          'Tap on the button to upload data',
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
