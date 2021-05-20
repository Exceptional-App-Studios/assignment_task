/*import 'package:flutter/material.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';
  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
  @override
  Widget build(BuildContext context) {
    //Task 6: Fetch Data from localdb.
    return Scaffold();
  }
}
*/
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';

  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
  TextEditingController nameController = TextEditingController();
  Future<Database> database;
  bool loadedDB = false;
  List<String> list;
  @override
  void initState() {
    createDatabase();
    super.initState();
  }

  createDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'Users.db'),
        onCreate: (db, version) async {
      await db.execute("CREATE TABLE users(name TEXT NOT NULL)");
    }, version: 1);
  }

  addNewmsg(String text) async {
    final db = await database;

    await db.insert(
      'data',
      {'text': text},
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    getTask();
    nameController.clear();
  }

  getTask() async {
    final db = await database;
    final List<Map<String, dynamic>> map = await db.query("task");
    var res = List<String>.generate(map.length, (index) {
      return map[index]['text'];
    });
    list = res;
    loadedDB = true;
    setState(() {});
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data fetched from local DB',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(height: 15),
              Expanded(
                child: loadedDB
                    ? ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300]),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              list[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[70],
                              ),
                            ),
                          );
                        })
                    : Center(child: CircularProgressIndicator()),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: new InputDecoration(
                    hintText: 'Enter a note',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  onPressed: () => addNewmsg(nameController.text),
                  child: Text(
                    'Save Data',
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
