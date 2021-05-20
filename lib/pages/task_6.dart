import 'package:assignment_app/models/DatabaseHelper.dart';
import 'package:assignment_app/models/todo.dart';
import 'package:flutter/material.dart';

class TaskSix extends StatefulWidget {
  static const routeName = 'task-six';
  @override
  _TaskSixState createState() => _TaskSixState();
}

class _TaskSixState extends State<TaskSix> {
  TextEditingController textController = TextEditingController();
  List<MyTodo> taskList = List();

  @override
  void initState() {
    super.initState();

    DatabaseHelper.instance.queryAllRows().then((value) {
      setState(() {
        value.forEach((element) {
          taskList.add(MyTodo(  id: element['id'], title: element["title"]));
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Task 6: Fetch Data from localdb.
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text("Data fetched from local db",style: TextStyle(fontSize: 24),),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  child: taskList.isEmpty
                      ? Container()
                      : getListView(),
                ),
              ),
              //Spacer(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Type a note here",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: textController,

              ),
              SizedBox(height: 20,),
              Container(
                width: 320,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    primary: Colors.green[700],
                  ),
                  onPressed: (){
                    _addToDb();
                    textController.text = "";
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

  Widget getListView() {
    return ListView.builder(itemBuilder: (ctx, index) {
      if (index == taskList.length) return null;
      return ListTile(
        title: Text(taskList[index].title,style: TextStyle(color: Colors.grey[600]),),
        //leading: Text(taskList[index].id.toString()),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteTask(taskList[index].id),
        ),
      );
    });
  }

  void _addToDb() async {
    String task = textController.text;
    var id = await DatabaseHelper.instance.insert(MyTodo(title: task));
    setState(() {
      taskList.insert(0, MyTodo(id: id, title: task));
    });
  }

  void _deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);
    setState(() {
      taskList.removeWhere((element) => element.id == id);
    });
  }
}
