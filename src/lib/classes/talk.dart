import 'tags.dart';
import 'person.dart';

class Talk {
  String id;
  String title;
  //String description;
  String beginTime;
  String endTime;
  List<String> tags;
  String speaker;





  Talk({String id, String title,String beginTime,String endTime,List<String> tags, String speaker}) {
    this.id = id;
    this.title = title;
    this.beginTime=beginTime;
    this.endTime=endTime;
    this.tags=tags;
    this.speaker = speaker;
  }





  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title' : title,
    'beginTime':beginTime,
    'endTime':endTime,
    'tags':tags,
    'speaker' : speaker
    };
  }


  Talk.fromData(Map<String, dynamic> data)
      : this.id = data['id'],
        this.endTime = data['endTime'],
        this.beginTime = data['beginTime'],
        this.title = data['title'],
        this.tags = data['tags'],
        this.speaker = data['speaker'];


}