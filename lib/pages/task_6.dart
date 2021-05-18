import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';
  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
   final _formKey = GlobalKey<FormState>();
  final msgController = TextEditingController();
  List<String> msgList;
  Future<Database> database;
  bool loadedDB=false;
  @override
  void initState() {
    initdb();
    super.initState();
  }

  initdb() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE data(text_string TEXT)",
        );
      },
      version: 1,
    );
    getAllMsgs();
  }

  @override
  Widget build(BuildContext context) {
    //Task 6: Fetch Data from localdb.
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal:15),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data Fetched from local DB', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.black),),
                SizedBox(height:15),
                Expanded(
                  child: loadedDB?ListView.builder(
                      itemCount: msgList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[300]),),
                          ),
                          padding:EdgeInsets.symmetric(horizontal:5,vertical: 10),
                          margin: EdgeInsets.only(bottom:10),
                          child: Text(msgList[index],
                          style: TextStyle(fontSize: 18,color:Colors.grey[70],),),
                        );
                      }):Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: msgController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: new InputDecoration(
                    hintText: 'Enter a note',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (str) {
                    if (str.length == 0) {
                      return "Please Enter a message!";
                    } else {
                      return null;
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 0, top: 20),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      primary: HexColor('#009154'),
                    ),
                    onPressed: () => insertmsg(msgController.text),
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
      ),
    );
  }

   insertmsg(String txt) async {
     if (!_formKey.currentState.validate()) {
       print("no Data");
    }
    else{
    final Database db = await database;
    await db.insert(
      'data',
      {'text_string': txt},
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
    getAllMsgs();
    }
    
    msgController.clear();    
  }

getAllMsgs() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('data');
  var listt =  List<String>.generate(maps.length, (i) {
    return maps[i]['text_string'];
  });
  msgList = listt;
  loadedDB=true;
  setState(() {
  });
return listt;
}


}
