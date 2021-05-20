import 'package:flutter/material.dart';

class UserData{
  final num id;
  final String name;
  final String email;
  final String collegeID;
  final String image_url;

  UserData({this.id,this.name,this.email,this.collegeID,this.image_url});

  factory UserData.fromJson(Map<String,dynamic> json) {
    return UserData(id: json["id"],name: json["name"],email: json["email"],collegeID: json["collegeID"],image_url: json["image_url"]);
  }

  @override
  String toString() {
    return '{${this.id},${this.name},${this.email},${this.collegeID},${this.image_url}}';
  }
}