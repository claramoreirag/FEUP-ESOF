import 'package:flutter_test/flutter_test.dart';
import 'package:hello/model/person.dart';
import 'package:hello/model/talk.dart';


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

  test('Calculate talks priority', () {
    final atendee = Atendee();
    atendee.addInterest('Cybersecurity');
    atendee.addInterest('AI');
    atendee.addInterest('Data Science');
    atendee.addInterest('Logic');
    
    var map = {'Cybersecurity':6, 'Data Science':2, 'AI':1, 'Logic':4};
    atendee.orderInterestsByPriority(map);

    Talk talk1 = Talk(id:'1', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Cybersecurity', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk2 = Talk(id:'2', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Data Science', 'AI'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk3 = Talk(id:'3', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    var talksPriorityMap = atendee.calculateTalksPriority(map, [talk1, talk2, talk3]);

    expect(talksPriorityMap, {talk1:10, talk2:3, talk3:7});
  });

  test('Comparing times', () {
    final atendee = Atendee();
    expect(atendee.isBefore('00:00', '00:01'), true);
    expect(atendee.isBefore('00:01', '00:00'), false);
    expect(atendee.isBefore('00:00', '12:00'), true);
    expect(atendee.isBefore('15:00', '13:45'), false);
    expect(atendee.isBefore('10:07', '9:59'), false);
    expect(atendee.isBefore('10:07', '10:07'), false);
  });

  test('Checking compatibility of dates and times of talks', () {
    final atendee = Atendee();

    Talk talk1 = Talk(id:'1', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Cybersecurity', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk2 = Talk(id:'2', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Data Science', 'AI'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk3 = Talk(id:'3', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'19/12/2020');

    Talk talk4 = Talk(id:'4', name:'TalkTitle', beginTime:'14:30', endTime:'16:30', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk5 = Talk(id:'5', name:'TalkTitle', beginTime:'12:30', endTime:'14:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk6 = Talk(id:'6', name:'TalkTitle', beginTime:'16:30', endTime:'17:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    expect(atendee.isCompatible(talk1, talk2), false);
    expect(atendee.isCompatible(talk1, talk3), true);
    expect(atendee.isCompatible(talk1, talk4), false);
    expect(atendee.isCompatible(talk1, talk5), true);
    expect(atendee.isCompatible(talk1, talk6), true);
  });

  test('Checking if a talk is compatible to a list of talks', () {
    final atendee = Atendee();

    Talk talk1 = Talk(id:'1', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Cybersecurity', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk2 = Talk(id:'2', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Data Science', 'AI'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk3 = Talk(id:'3', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'19/12/2020');

    Talk talk4 = Talk(id:'4', name:'TalkTitle', beginTime:'14:30', endTime:'16:30', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk5 = Talk(id:'5', name:'TalkTitle', beginTime:'12:30', endTime:'14:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    Talk talk6 = Talk(id:'6', name:'TalkTitle', beginTime:'16:30', endTime:'17:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    expect(atendee.isTalkCompatible([talk3, talk5, talk6], talk1), true);
    expect(atendee.isTalkCompatible([talk1, talk5, talk6], talk3), true);
    expect(atendee.isTalkCompatible([talk1, talk3, talk6], talk5), true);
    expect(atendee.isTalkCompatible([talk1, talk3, talk5], talk6), true);
    expect(atendee.isTalkCompatible([talk1, talk3, talk6], talk2), false);
    expect(atendee.isTalkCompatible([talk1, talk3, talk6], talk4), false);
  });

  test('Selecting which talks to attend', () {
    final atendee = Atendee();

    Talk talk1 = Talk(id:'1', name:'TalkTitle1', beginTime:'14:00', endTime:'16:00', tags:['Cybersecurity', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');
    Talk talk2 = Talk(id:'2', name:'TalkTitle2', beginTime:'14:00', endTime:'16:00', tags:['Data Science', 'AI'], 
      speaker:'mockSpeaker', date:'18/12/2020');
    Talk talk3 = Talk(id:'3', name:'TalkTitle3', beginTime:'14:00', endTime:'16:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'19/12/2020');
    Talk talk4 = Talk(id:'4', name:'TalkTitle4', beginTime:'14:30', endTime:'16:30', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');
    Talk talk5 = Talk(id:'5', name:'TalkTitle5', beginTime:'12:30', endTime:'14:00', tags:['AI', 'Data Science', 'Cybersecurity'], 
      speaker:'mockSpeaker', date:'18/12/2020');
    Talk talk6 = Talk(id:'6', name:'TalkTitle6', beginTime:'16:30', endTime:'17:00', tags:['AI', 'Data Science', 'Logic'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    atendee.orderInterestsByPriority({'Cybersecurity':6, 'Data Science':2, 'AI':1, 'Logic':4});
    atendee.selectTalksToAttend([talk1, talk2, talk3, talk4, talk5, talk6]);

    expect(atendee.talks, [talk1, talk5, talk3, talk6]);
  });
}