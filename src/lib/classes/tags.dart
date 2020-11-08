class Tags {
  int id;
  String title;

  Tags({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
