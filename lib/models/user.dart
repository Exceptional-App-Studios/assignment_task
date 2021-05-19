import 'package:flutter/material.dart';

class user {
  final String Firstname;
  final String Image;
  final String Email;

  const user({
    this.Firstname,
    this.Image,
    this.Email,
});
  static user fromJson(Json) => user(
    Firstname: Json['Firstname'],
    Image: Json['Image'],
    Email: Json['Email'],
  );
}

