class ModelData {
  String Name;
  String Email;
  String ID;

  ModelData({this.Name, this.Email, this.ID});

  Map<String, String> toJson() => _$Modeltojson(this);

  Map<String, String> _$Modeltojson(ModelData obj) =>
      <String, String>{'full name': obj.Name, 'Email': obj.Email, 'ID': obj.ID};
}
