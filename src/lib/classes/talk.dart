import 'tags.dart';
import 'person.dart';

class Talk {
  int id;
  String title;
  String description;
  List<dynamic> tags = [];
  Speaker speaker;





  Talk(int id, String title, String description, Speaker speaker) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.speaker = speaker;
  }

  void addTag(Tags tag) {
    tags.add(tag);
  }
}
