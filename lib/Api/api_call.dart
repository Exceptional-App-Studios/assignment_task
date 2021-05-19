import 'dart:convert';

import 'package:assignment_app/models/chat_data.dart';
import 'package:assignment_app/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class ApiCall {
  static Future<UserInfo> GetUserData(int index) async {
    final dataurl = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/mystical-glass-250612.appspot.com/o/data.json?alt=media&token=5b20f992-6f7a-4f10-b6a3-b1e1e06f8182');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);
    UserInfo info = UserInfo.storedata(body['User'][index]);
    print(info.firstname.toString());

    return info;
  }

  static Future<List<UserInfo>> userList() async {
    final dataurl = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/mystical-glass-250612.appspot.com/o/data.json?alt=media&token=5b20f992-6f7a-4f10-b6a3-b1e1e06f8182');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);

    return body['User'].map<UserInfo>(UserInfo.storedata).toList();
  }

  static Future<List<ChartData>> ReadChartData() async {
    final dataurl = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/mystical-glass-250612.appspot.com/o/data.json?alt=media&token=5b20f992-6f7a-4f10-b6a3-b1e1e06f8182');
    final response = await http.get(dataurl);
    final body = json.decode(response.body);
    print(body['chartdata'][0]);
    return body['chartdata'].map<ChartData>(ChartData.fromJson).toList();
  }

  static Future<List<ChartData>> ReadChartDataLocal(String data) async {
    final body = json.decode(data);
    return body.map<ChartData>(ChartData.fromJson).toList();
  }
}
