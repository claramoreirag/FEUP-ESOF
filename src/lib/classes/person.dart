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

class User {
  
  List<String> interests;
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  final String location;
  final String profilePhoto;
  final String phoneNumber;
  final String linkedIn;
  final String cv;
  
  User({this.id, this.fullName, this.email, this.userRole, this.location, this.profilePhoto, this.phoneNumber, this.linkedIn, this.cv});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        location = data['location'],
        profilePhoto = data['profilePhoto'],
        phoneNumber = data['phoneNumber'],
        linkedIn=data['linkedIn'],
        cv=data['cv'];

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
      'cv':cv
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
