import 'package:flutter_test/flutter_test.dart';
import 'package:hello/classes/conference.dart';
import 'package:hello/classes/talk.dart';


void main() {
  test('Keywords should be added to conference whenever the function is called', () {
    final conference = Conference();

    //First talk has 2 tags
    Talk talk = Talk(id:'1', name:'TalkTitle', beginTime:'14:00', endTime:'16:00', tags:['Cybersecurity', 'AI'], 
      speaker:'mockSpeaker', date:'18/12/2020');

    //Second talk has 2 tags
    Talk talk2 = Talk(id:'2', name:'Talk2', beginTime:'15:00', endTime:'16:00', tags:['Data Science', 'AI'], 
      speaker:'mockSpeaker2', date:'18/12/2020');

    //Third talk has no tags
    Talk talk3 = Talk(id:'3', name:'Talk3', beginTime:'16:00', endTime:'17:00', tags:[], 
      speaker:'mockSpeaker3', date:'18/12/2020');

    //Verifying length of talks list
    expect(conference.talks.length, 0);

    conference.talks.add(talk);
    expect(conference.talks.length, 1);

    conference.talks.add(talk2);
    expect(conference.talks.length, 2);

    conference.talks.add(talk3);
    expect(conference.talks.length, 3);

    expect(conference.keywords.length, 0);

    //Adding keywords
    conference.addKeywords();

    expect(conference.keywords.length, 3);

    expect(conference.keywords[0], 'Cybersecurity');
    expect(conference.keywords[1], 'AI');
    expect(conference.keywords[2], 'Data Science');
  });

}