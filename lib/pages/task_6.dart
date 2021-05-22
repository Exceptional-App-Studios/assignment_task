import 'package:assignment_app/models/note.dart';
import 'package:assignment_app/pages/edit.dart';
import 'package:assignment_app/service/db.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:flutter/material.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';
  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {

  List<Note> notes;

  bool loading = true;

  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Task 6: Fetch Data from localdb.
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES'),
      ),
      body: loading
          ? Loading()
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Note note = notes[index];
                  return Card(
                    elevation: 0,
                    color: Colors.grey[100],
                    child: ListTile(
                      title: Text(
                        note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        note.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (context) => Edit(note: note)))
                            .then((value) => refresh());
                      },
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => Edit(note: new Note())))
                    .then((value) => refresh());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add Note',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
