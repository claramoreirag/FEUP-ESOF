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
  List interests;
  User(id, name, email, password, interests) : super(name) {
    this.id = id;
    this.email = email;
    this.password = password;

    this.interests = interests;
  }
}
