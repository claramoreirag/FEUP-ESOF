import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello/classes/talk.dart';
import 'package:hello/classes/person.dart';
import 'package:hello/classes/tags.dart' as our;

import 'package:mockito/mockito.dart';

class MockSpeaker extends Mock implements Speaker {}
class MockTags extends Mock implements our.Tags {}



void main(){
  test('Talks test', () {
  	MockSpeaker mockSpeaker = MockSpeaker();
  	MockTags mockTag1 = MockTags();
  	MockTags mockTag2 = MockTags();
  	MockTags mockTag3 = MockTags();

  	Talk talk = Talk(1, 'TalkTitle', 'RandomDescription', mockSpeaker);

  	expect(talk.id, 1);
  	expect(talk.title, 'TalkTitle');
  	expect(talk.description, 'RandomDescription');
  	expect(talk.speaker, mockSpeaker);

  	expect(talk.tags.length, 0);

  	talk.addTag(mockTag1);
  	expect(talk.tags.length, 1);
  	expect(talk.tags[0], mockTag1);

  	talk.addTag(mockTag2);
  	expect(talk.tags.length, 2);
  	expect(talk.tags[1], mockTag2);

  	talk.addTag(mockTag3);
  	expect(talk.tags.length, 3);
  	expect(talk.tags[2], mockTag3);
  });
}