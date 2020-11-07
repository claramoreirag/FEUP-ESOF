class Conference {
  int id;
  String title;
  String description;
  List talks;

  Conference({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
