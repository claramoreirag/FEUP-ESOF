import 'tags.dart';

class Person {
  String name;

  Person(name) {
    this.name = name;
  }
}

class Speaker extends Person {
  String cv;
  String linkedIn;

  Speaker(name, cv, linkedIn) : super(name) {
    this.cv = cv;
    this.linkedIn = linkedIn;
  }
}

class User extends Person {
  int id;
  String email;
  String password;
  List<String> interests;
  User(id, name, email, password, interests) : super(name) {
    this.id = id;
    this.email = email;
    this.password = password;
    this.interests = List<String>();
  }

  addInterest(String keyword) {
    if (interests.length == 0 || !interests.contains(keyword)){
      this.interests.add(keyword);
      
    }
  }

  removeInterest(String keyword){
    if(interests.contains(keyword))
      interests.remove(keyword);
  }
}
