class ModelData {
  String name;
  String email;
  String collegeId;

  ModelData({this.name, this.email, this.collegeId});

  Map<String, String> toJson() => _$Modeltojson(this);

  Map<String, String> _$Modeltojson(ModelData obj) => <String, String>{
        'name': obj.name,
        'email': obj.email,
        'collegeId': obj.collegeId
      };
}
