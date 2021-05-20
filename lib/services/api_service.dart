import 'dart:convert';
import 'package:http/http.dart';

class ApiLink {

  Future<Map<String, dynamic>> getUser() async {
    final response = await get(
        Uri.parse('https://exceptional-studios.herokuapp.com/api/users/'));
    return jsonDecode(response.body)[0];
  }

  Future<List<dynamic>> getUsers() async {
    final response = await get(
        Uri.parse('https://exceptional-studios.herokuapp.com/api/users/'));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getGraph() async {
    final response = await get(
        Uri.parse('https://exceptional-studios.herokuapp.com/api/graph-task'));
    return jsonDecode(response.body);
  }

  Future<String> getSong() async {
    final response = await get(
        Uri.parse('https://exceptional-studios.herokuapp.com/api/audio-task'));
    return jsonDecode(response.body)['audio_file'];
  }

  Future<bool> postTask3Details(
      String name, String email, String collegeId) async {
    final response = await post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {"name": name, "email": email, "college_id": collegeId});
    return response.statusCode == 201;
  }

  Future<bool> createUser(String name, String email, String collegeId) async {
    final response = await post(
        Uri.parse('https://exceptional-studios.herokuapp.com/api/users/'),
        body: {"name": name, "email": email, "collegeId": collegeId});
    return response.statusCode == 201;
  }
}
