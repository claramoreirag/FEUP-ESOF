class Conference {
  int id;
  String title;
  String description;
  List talks = [];
  List keywords = [];

  Conference({this.id, this.title});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }

  

  //add function that adds the keywords to the conference

  List<dynamic> addKeywords(){
    for (int i = 0; i < this.talks.length; i++){
     for (int j = 0; j < talks[i].tags.length; j++){
       if(!keywords.contains(talks[i].tags[j].title))
          keywords.add(talks[i].tags[j].title);
     }
    }

    return keywords;
  }
}
