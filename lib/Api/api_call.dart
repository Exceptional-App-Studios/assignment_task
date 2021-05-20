import 'dart:convert';

import 'package:assignment_app/models/chart_data.dart';
import 'package:assignment_app/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  static Future<UserInfo> GetUserData(int index) async {
    final dataurl =
        Uri.parse('https://exceptional-studios.herokuapp.com/api/users/');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);
    UserInfo info = UserInfo.storedata(body[index]);

    return info;
  }

  static Future<List<UserInfo>> userList() async {
    final dataurl =
        Uri.parse('https://exceptional-studios.herokuapp.com/api/users/');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);

    return body.map<UserInfo>(UserInfo.storedata).toList();
  }

  static Future<List<Chartdata>> ReadChartData() async {
    final dataurl =
        Uri.parse('https://exceptional-studios.herokuapp.com/api/graph-task');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);
    print(body[0]);
    return body.map<Chartdata>(Chartdata.fromJson).toList();
  }
}
