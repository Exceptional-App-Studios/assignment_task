import 'package:assignment_app/models/note.dart';
import 'package:assignment_app/service/db.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {

  final Note note;

  Edit({this.note});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool loading = false, editMode = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    if(widget.note.id != null){
      editMode = true;
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Edit' : 'New Note'),
        actions: [
          if(editMode) IconButton(icon: Icon(Icons.delete), onPressed: (){
            setState(() {
              loading = true;
              delete();
            });
          })
        ],
      ),
      body: loading ? Loading() : ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: contentController,
            maxLines: 25,
            decoration: InputDecoration(
              hintText: 'Details',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                loading = true;
              });
              save();
              titleController.text = '';
              contentController.text = '';
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Save Note',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  Future<void> save() async {
    if(titleController.text != ''){
      widget.note.title = titleController.text;
      widget.note.content = contentController.text;
      if(editMode) await DB().update(widget.note);
      else await DB().add(widget.note);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> delete() async {
    await DB().delete(widget.note);
    Navigator.pop(context);
  }


}
