class UserPost {
    UserPost({
        this.id,
        this.name,
        this.email,
        this.collegeId,
        this.imageUrl,
    });

    int id;
    String name;
    String email;
    String collegeId;
    String imageUrl;

    factory UserPost.fromMap(Map<String, dynamic> json) => UserPost(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        collegeId: json["collegeId"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "collegeId": collegeId,
        "image_url": imageUrl,
    };
}
