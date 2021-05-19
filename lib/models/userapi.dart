import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:assignment_app/models/user.dart';
import 'package:http/http.dart' as http;

class userapi {
  static Future<user> GetuserData(int index) async {
    final url = Uri.parse('https://firebasestorage.googleapis.com/v0/b/fire-1ce9b.appspot.com/o/Dhruv.json?alt=media&token=8de06ec9-5216-4580-bb6f-21bfdc8ea77a');
    final responce = await http.get(url);
    final body = json.decode(responce.body);

    user data = user.fromJson(body['User'][index]);

    return data;
  }
  static Future<List<user>> userList() async {
    final url = Uri.parse('https://firebasestorage.googleapis.com/v0/b/fire-1ce9b.appspot.com/o/Dhruv.json?alt=media&token=8de06ec9-5216-4580-bb6f-21bfdc8ea77a');
    final responce = await http.get(url);
    final body = json.decode(responce.body);

    return body['User'].map<user>(user.fromJson).toList();
  }
}