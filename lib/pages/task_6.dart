
import 'package:assignment_app/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';

  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
  final noteController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data fetched from local database',style: TextStyle(fontSize: MediaQuery.of(context).size.width/22,fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                Container(
                  height: height * 0.6,
                  child: ValueListenableBuilder<Box>(
                    valueListenable: Hive.box('notes').listenable(),
                    builder: (context, notesBox, widget) {
                      if (notesBox.values.length == 0)
                        return Container(
                            child: Text('This is example text from local database.',style: TextStyle(fontSize: MediaQuery.of(context).size.width/22),));
                      return ListView.builder(
                        itemCount: notesBox.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(notesBox.getAt(index)['note']),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => notesBox.deleteAt(index),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Type your Note here',
                    ),
                    controller: noteController,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        elevation: 1,
                        primary: Colors.green,
                      ),
                      onPressed: () async {
                        if (noteController.text.length > 0) {
                          DBService().addNote(noteController.text);
                          noteController.clear();
                        } else
                          print('enter something');
                      },
                      child: Text(
                        'Save data',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
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
}