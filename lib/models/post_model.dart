import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
    PostModel({
        this.name,
        this.email,
        this.collegeId,
    });

    String name;
    String email;
    String collegeId;

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json["name"],
        email: json["email"],
        collegeId: json["collegeId"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "collegeId": collegeId,
    };
}
