import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello/model/talk.dart';

void main() {
  test('Talks test', () {
    Talk talk = Talk(
        id: '1',
        name: 'TalkTitle',
        beginTime: '14:00',
        endTime: '16:00',
        tags: [],
        speaker: 'mockSpeaker',
        date: '18/12/2020');

    expect(talk.id, '1');
    expect(talk.name, 'TalkTitle');
    expect(talk.beginTime, '14:00');
    expect(talk.endTime, '16:00');
    expect(talk.speaker, 'mockSpeaker');
    expect(talk.date, '18/12/2020');
    expect(talk.tags.length, 0);

    talk.tags.add('mockTag1');
    expect(talk.tags.length, 1);
    expect(talk.tags[0], 'mockTag1');

    talk.tags.add('mockTag2');
    expect(talk.tags.length, 2);
    expect(talk.tags[1], 'mockTag2');

    talk.tags.add('mockTag3');
    expect(talk.tags.length, 3);
    expect(talk.tags[2], 'mockTag3');
  });
}
