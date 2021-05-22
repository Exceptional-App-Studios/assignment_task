import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:assignment_app/models/user.dart';

class ApiService {



  Future<List<User>> getUserList() async {
    final res = await http
        .get(Uri.parse("https://exceptional-studios.herokuapp.com/api/users/"));

    if (res.statusCode != 200) throw Exception();

    List body = jsonDecode(res.body);

    return body.map((data) => User.fromJSon(data)).toList();
  }

  

}