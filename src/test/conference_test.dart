import 'package:flutter_test/flutter_test.dart';
import 'package:hello/classes/conference.dart';
import 'package:hello/classes/talk.dart';
import 'package:hello/classes/person.dart';
import 'package:mockito/mockito.dart';
import 'package:hello/classes/tags.dart' as our;


class MockSpeaker extends Mock implements Speaker {}


void main() {
  test('Keywords should be added to conference whenever the function is called', () {
    final conference = Conference();
    MockSpeaker mockSpeaker = MockSpeaker();
    MockSpeaker mockSpeaker2 = MockSpeaker();
    MockSpeaker mockSpeaker3 = MockSpeaker();
    our.Tags aiTag = our.Tags(id:2, title:'AI');

    //First talk has 2 tags
    Talk talk1 = Talk(1, 'TalkTitle', 'RandomDescription', mockSpeaker);
    talk1.addTag(our.Tags(id:1, title:'Cybersecurity'));
    talk1.addTag(aiTag);

    //Second talk has 2 tags
    Talk talk2 = Talk(2, 'Good title', 'Interesting description', mockSpeaker2);
    talk2.addTag(our.Tags(id:3, title:'Data Science'));
    talk2.addTag(aiTag);

    //Third talk has no tags
    Talk talk3 = Talk(3, 'Boring title', 'Boring description', mockSpeaker3);

    //Verifying length of talks list
    expect(conference.talks.length, 0);

    conference.talks.add(talk1);
    expect(conference.talks.length, 1);

    conference.talks.add(talk2);
    expect(conference.talks.length, 2);

    conference.talks.add(talk3);
    expect(conference.talks.length, 3);

    expect(conference.keywords.length, 0);

    //Adding keywords
    conference.addKeywords();

    expect(conference.keywords.length, 4);

    expect(conference.keywords[0], 'Cybersecurity');
    expect(conference.keywords[1], 'AI');
    expect(conference.keywords[2], 'Data Science');
    expect(conference.keywords[3], 'AI');
  });

}