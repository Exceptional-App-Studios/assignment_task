import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:assignment_app/models/user.dart';

class ApiService {

  Future<User> getUser() async {
    final response = await http.get(
        Uri.parse("https://exceptional-studios.herokuapp.com/api/users/1/"));

    if (response.statusCode != 200) throw Exception();

    return new User.fromJSon(json.decode(response.body));
    
  }

  Future<List<User>> getUserList() async {
    final res = await http
        .get(Uri.parse("https://exceptional-studios.herokuapp.com/api/users/"));

    if (res.statusCode != 200) throw Exception();

    List body = jsonDecode(res.body);

    return body.map((data) => User.fromJSon(data)).toList();
  }

  

}