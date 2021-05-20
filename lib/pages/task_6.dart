import 'package:assignment_app/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// no need for changing states so using stateless widget
class TaskSix extends StatelessWidget {
  static const routeName = 'task-six';
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //Task 6: Fetch Data from local db.
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Data fetched from the local database'),
              SizedBox(height: 20),
              Container(
                height: height * 0.6,
                child: ValueListenableBuilder<Box>(
                  valueListenable: Hive.box('notes').listenable(),
                  builder: (context, notesBox, widget) {
                    if (notesBox.values.length == 0)
                      return Container(
                          child: Center(child: Text('Start adding some data')));
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
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Type your Note here',
                    labelText: 'Note',
                  ),
                  controller: noteController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
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
            ],
          ),
        ),
      ),
    );
  }
}
