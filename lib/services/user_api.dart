import 'dart:convert';

import 'package:assignment_app/constants/strings.dart';
import 'package:assignment_app/models/post_model.dart';
import 'package:assignment_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<UserModel> getUser() async {
    var client = http.Client();
    var userModel;

    try {
      var response = await client.get(Uri.parse(Strings.user_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        userModel = UserModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return userModel;
    }
    return userModel;
  }

  Future<List<UserModel>> getUsers() async {
    var client = http.Client();
    List<UserModel> users = [];

    try {
      var response = await client.get(Uri.parse(Strings.users_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        for (var u in jsonMap){
          UserModel user = UserModel.fromJson(u);
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

  Future<PostModel> createUser(String name, String email, String collegeId) async{

  final response = await http.post(Uri.parse(Strings.users_url), body: {
    "name": name,
    "email": email,
    "collegeId": collegeId
  });

  if(response.statusCode == 201){
    final String responseString = response.body;
    
    return postModelFromJson(responseString);
  }else{
    return null;
  }
}

}