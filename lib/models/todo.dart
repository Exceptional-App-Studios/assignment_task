class MyTodo {
  int id;
  String title;

  MyTodo({this.id,this.title});

  Map<String,dynamic> toMap(){
    return {'id': id, 'title': title};
  }
}