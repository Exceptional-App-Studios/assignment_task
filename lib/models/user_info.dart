import 'package:flutter/material.dart';

class UserInfo {
  final String firstname;
  final String image;
  final String email;

  UserInfo({
    @required this.firstname,
    @required this.image,
    @required this.email,
  });

  static UserInfo storedata(json) => UserInfo(
      firstname: json['Firstname'], image: json['Image'], email: json['Email']);
}
