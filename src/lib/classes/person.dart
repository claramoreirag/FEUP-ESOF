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
  List<String> interests;
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
      this.conference});

  Atendee.fromData(Map<String, dynamic> data)
      : this.id = data['id'],
        this.fullName = data['fullName'],
        this.email = data['email'],
        this.userRole = data['userRole'],
        this.location = data['location'],
        this.profilePhoto = data['profilePhoto'],
        this.phoneNumber = data['phoneNumber'],
        this.linkedIn = data['linkedIn'],
        this.cv = data['cv'],
        this.conference=data['conference'];

  fromData(Map<String, dynamic> data){
       this.id = data['id'];
        this.fullName = data['fullName'];
        this.email = data['email'];
        this.userRole = data['userRole'];
        this.location = data['location'];
        this.profilePhoto = data['profilePhoto'];
        this.linkedIn = data['linkedIn'];
        this.cv = data['cv'];
        this.conference=data['conference'];}

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
      'conference':conference
    };
  }

  addInterest(String keyword) {
    if (interests.length == 0 || !interests.contains(keyword)) {
      this.interests.add(keyword);
    }
  }

  removeInterest(String keyword) {
    if (interests.contains(keyword)) interests.remove(keyword);
  }

  orderInterestsByPriority(Map<String, int> map) {
    if (map.isNotEmpty) {
      for (int i = 0; i < interests.length; i++) {
        if (!map.keys.contains(interests[i])) map[interests[i]] = 0;
      }
      interests.sort((a, b) => map[b].compareTo(map[a]));
    }
  }
}
