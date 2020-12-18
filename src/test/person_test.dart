import 'package:flutter_test/flutter_test.dart';
import 'package:hello/model/person.dart';

void main() {
  test('Testing Speaker class', () {
    Speaker speaker = Speaker('NameTest', 'CVtest', 'LinkedInTest');

    expect(speaker.name, 'NameTest');
    expect(speaker.cv, 'CVtest');
    expect(speaker.linkedIn, 'LinkedInTest');
  });

  test(
      'Interest should be added and removed whenever these functions are called',
      () {
    final atendee = Atendee(
        id: 'id',
        fullName: 'fullname',
        email: 'email',
        userRole: 'role',
        location: 'location',
        profilePhoto: 'photo',
        phoneNumber: 'number',
        linkedIn: 'li',
        cv: 'cv',
        conference: 'conf',
        interests: []);
    expect(atendee.interests.length, 0);
    atendee.addInterest('Cybersecurity');
    expect(atendee.interests[0], 'Cybersecurity');
    expect(atendee.interests.length, 1);

    atendee.removeInterest('Data Science');
    expect(atendee.interests[0], 'Cybersecurity');
    expect(atendee.interests.length, 1);

    atendee.removeInterest('Cybersecurity');
    expect(atendee.interests.length, 0);
  });

  test('Ordering interests by priority', () {
    final atendee = Atendee();
    atendee.addInterest('Cybersecurity');
    atendee.addInterest('AI');
    atendee.addInterest('Data Science');
    atendee.addInterest('Algorithms');
    atendee.addInterest('Logic');
    atendee.addInterest('Not in map 1');
    atendee.addInterest('Not in map 2');
    atendee.addInterest('Not in map 3');
    atendee.addInterest('Not in map 4');

    var map = {'Cybersecurity': 6, 'Data Science': 2, 'AI': 1, 'Logic': 4};
    atendee.orderInterestsByPriority(map);

    expect(atendee.interests.length, 9);
    expect(atendee.priorities, map);
  });
}
