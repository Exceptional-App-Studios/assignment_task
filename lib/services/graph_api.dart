import 'dart:convert';

import 'package:assignment_app/constants/strings.dart';
import 'package:assignment_app/models/graph_model.dart';
import 'package:http/http.dart' as http;

class GraphApi{

  Future<List<GraphModel>> getDataofChart() async {
    var client = http.Client();
    List<GraphModel> users = [];

    try {
      var response = await client.get(Uri.parse(Strings.graph_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        for (var u in jsonMap){
          GraphModel user = GraphModel.fromJson(u);
          users.add(user);
          print(user);
        }
      }
      print(users);
    } catch (Exception) {
      return users;
    }
    print(users.length);
    return users;
  }  

}