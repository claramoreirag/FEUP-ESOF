import 'package:hello/model/talk.dart';

class Speaker {
  String name;
  String cv;
  String linkedIn;

  Speaker(name, cv, linkedIn) {
    this.name = name;
    this.cv = cv;
    this.linkedIn = linkedIn;
  }
}

class Atendee {
  List<String> interests = new List();
  String id;
  String fullName;
  String email;
  String userRole;
  String location;
  String profilePhoto;
  String phoneNumber;
  String linkedIn;
  String cv;
  String conference;
  List<Talk> talks;
  Map<String, int> priorities;
  Atendee(
      {this.id,
      this.fullName,
      this.email,
      this.userRole,
      this.location,
      this.profilePhoto,
      this.phoneNumber,
      this.linkedIn,
      this.cv,
      this.conference,
      this.interests});

  Atendee.withoutInterests(
      {String id,
      String fullName,
      String email,
      String userRole,
      String location,
      String profilePhoto,
      String phoneNumber,
      String linkedIn,
      String cv,
      String conference})
      : this(
            id: id,
            fullName: fullName,
            email: email,
            userRole: userRole,
            location: location,
            profilePhoto: profilePhoto,
            phoneNumber: phoneNumber,
            linkedIn: linkedIn,
            cv: cv,
            conference: conference,
            interests: new List());

  Atendee.fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.fullName = data['fullName'];
    this.email = data['email'];
    this.userRole = data['userRole'];
    this.location = data['location'];
    this.profilePhoto = data['profilePhoto'];
    this.phoneNumber = data['phoneNumber'];
    this.linkedIn = data['linkedIn'];
    this.cv = data['cv'];
    this.conference = data['conference'];
    this.talks = new List();
    print(data['talks']);
    if (data['talks'] != null) {
      if (data['talks'].length > 0) {
        for (var talk in data['talks']) {
          talks.add(Talk.fromData(talk));
        }
      }
    }
  }

  fromData(Map<String, dynamic> data) {
    this.id = data['id'];
    this.fullName = data['fullName'];
    this.email = data['email'];
    this.userRole = data['userRole'];
    this.location = data['location'];
    this.profilePhoto = data['profilePhoto'];
    this.linkedIn = data['linkedIn'];
    this.cv = data['cv'];
    this.conference = data['conference'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'location': location,
      'profilePhoto': profilePhoto,
      'phoneNumber': phoneNumber,
      'linkedIn': linkedIn,
      'cv': cv,
      'conference': conference,
      'interests': interests
    };
  }

  addInterest(String keyword) {
    if (interests == null) {
      interests = new List();
    }
    if (interests.length == 0 || !interests.contains(keyword)) {
      this.interests.add(keyword);
    }
    print('INTERESTS:    +' + interests.toString());
  }

  removeInterest(String keyword) {
    if (interests == null) {
      interests = new List();
    }
    if (interests.contains(keyword)) {
      var x = this.interests.remove(keyword);
      print(x.toString());
    }
  }

  orderInterestsByPriority(Map<String, int> map) {
    // if (map.isNotEmpty) {
    //   for (int i = 0; i < interests.length; i++) {
    //     if (!map.keys.contains(interests[i])) map[interests[i]] = 0;
    //   }
    //   interests.sort((a, b) => map[b].compareTo(map[a]));
    // }
    this.priorities = map;
  }

  calculateTalksPriority(Map<String, int> map, List<Talk> talks) {
    Map<Talk, int> talksByPriority = Map<Talk, int>();
    for (int i = 0; i < talks.length; i++) {
      int priority = 0;
      for (int j = 0; j < talks[i].tags.length; j++) {
        if (map.keys.contains(talks[i].tags[j]) && map[talks[i].tags[j]] > 0)
          priority += map[talks[i].tags[j]];
      }
      talksByPriority[talks[i]] = priority;
    }
    return talksByPriority;
  }

  isBefore(String hour1, String hour2) {
    //só comparar se os dias forem iguais
    var info1 = hour1.split(":");
    var info2 = hour2.split(":");
    int hour_1 = int.parse(info1[0]) * 100 + int.parse(info1[1]);
    int hour_2 = int.parse(info2[0]) * 100 + int.parse(info2[1]);
    return hour_1 < hour_2;
  }

  isCompatible(Talk talk1, Talk talk2) {
    if (talk1.date != talk2.date) return true;
    if (talk1.endTime == talk2.beginTime ||
        isBefore(talk1.endTime, talk2.beginTime)) return true;
    if (talk2.endTime == talk1.beginTime ||
        isBefore(talk2.endTime, talk1.beginTime)) return true;
    return false;
  }

  isTalkCompatible(List<Talk> talks, Talk talk) {
    for (int i = 0; i < talks.length; i++) {
      if (!isCompatible(talks[i], talk)) return false;
    }
    return true;
  }

  selectTalksToAttend(List<Talk> conferenceTalks) {
    Map<Talk, int> talksByPriority =
        calculateTalksPriority(this.priorities, conferenceTalks);
    conferenceTalks
        .sort((a, b) => talksByPriority[b].compareTo(talksByPriority[a]));
    talks.clear();
    talks.add(conferenceTalks[0]);
    for (int i = 1; i < conferenceTalks.length; i++) {
      if (isTalkCompatible(talks, conferenceTalks[i]) &&
          talksByPriority[conferenceTalks[i]] > 0) {
        talks.add(conferenceTalks[i]);
      }
    }
  }
}
