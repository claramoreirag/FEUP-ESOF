import 'tags.dart';
import 'person.dart';

class Talk {
  String id;
  String name;
  //String description;
  String beginTime;
  String endTime;
  List<String> tags;
  String speaker;
  String date;

  Talk(
      {String id,
      String name,
      String beginTime,
      String endTime,
      List<String> tags,
      String speaker,
      String date}) {
    this.id = id;
    this.name = name;
    this.beginTime = beginTime;
    this.endTime = endTime;
    this.tags = tags;
    this.speaker = speaker;
    this.date = date;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'beginTime': beginTime,
      'endTime': endTime,
      'tags': tags,
      'speaker': speaker,
      'date': date
    };
  }

  Talk.fromData(Map<String, dynamic> data)
      : this.id = data['id'],
        this.endTime = data['endTime'],
        this.beginTime = data['beginTime'],
        this.name = data['name'],
        this.tags = data['tags'],
        this.speaker = data['speaker'],
        this.date = data['date'];
}
