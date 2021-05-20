// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  Note({
    this.note,
    this.time,
  });

  String note;
  int time;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        note: json["note"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "time": time,
      };
}
