import 'package:flutter_test/flutter_test.dart';
import 'package:hello/classes/person.dart';

void main() {
  test('Interest should be added and removed whenever these functions are called', () {
    final atendee = Atendee();
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

    atendee.orderInterestsByPriority({'Cybersecurity':6, 'Data Science':2, 'AI':1, 'Logic':4});

    expect(atendee.interests.length, 9);
    expect(atendee.interests[0], 'Cybersecurity');
    expect(atendee.interests[1], 'Logic');
    expect(atendee.interests[2], 'Data Science');
    expect(atendee.interests[3], 'AI');
    expect(atendee.interests[4], 'Algorithms');
    expect(atendee.interests[5], 'Not in map 1');
    expect(atendee.interests[6], 'Not in map 2');
    expect(atendee.interests[7], 'Not in map 3');
    expect(atendee.interests[8], 'Not in map 4');
  });
}