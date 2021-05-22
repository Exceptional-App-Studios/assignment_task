import 'package:assignment_app/models/user.dart';
import 'package:assignment_app/service/service.dart';
import 'package:flutter/material.dart';

class TaskTwo extends StatefulWidget {
  static const routeName = 'task-two';
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {

ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    //Hint: You can use ListView/Listview.builder() to do this.
     return Scaffold(
      body: FutureBuilder(
        future: apiService.getUserList(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            List<User> udata = snapshot.data;
            return ListView.builder(
                itemCount: udata.length,
                itemBuilder: (context, index) =>
                    customListTile(udata[index], context));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
 
  }
    Widget customListTile(User udata, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          udata.url != null
              ? Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(udata.url), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(child: Text("No image Found"))),
          Text(
            udata.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

}
