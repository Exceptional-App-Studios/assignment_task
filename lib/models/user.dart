class User {
  final int id;
  final String name;
  final String url;

  User({this.id, this.name, this.url});

  factory User.fromJSon(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"], url: json["image_url"]);
  }
}
