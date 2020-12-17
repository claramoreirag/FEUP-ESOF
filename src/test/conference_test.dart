import 'package:flutter_test/flutter_test.dart';
import 'package:hello/classes/conference.dart';
import 'package:hello/classes/talk.dart';
import 'package:mockito/mockito.dart';

class MockTalk extends Mock implements Talk {}

void main() {
  test('Keywords should be added to conference whenever the function is called', () {
    // final conference = Conference();
    // MockTalk mockTalk1 = MockTalk();
    // MockTalk mockTalk2 = MockTalk();
    // MockTalk mockTalk3 = MockTalk();

    // expect(conference.keywords.length, 0);


    // when(mockTalk1.tags.length).thenReturn(2);
    // when(mockTalk1.tags[0].title).thenReturn('Cybersecurity');
    // when(mockTalk1.tags[1].title).thenReturn('AI');

    // when(mockTalk2.tags.length).thenReturn(2);
    // when(mockTalk2.tags[0].title).thenReturn('Data Science');
    // when(mockTalk2.tags[1].title).thenReturn('AI');

    // when(mockTalk3.tags.length).thenReturn(2);
    // when(mockTalk3.tags[0].title).thenReturn('Data Science');
    // when(mockTalk3.tags[1].title).thenReturn('Logic');

    // conference.talks = List(3);
    // conference.talks = [mockTalk1, mockTalk2, mockTalk3];

    // print(conference.talks);


    // conference.addKeywords();

    // expect(conference.keywords.length, 4);

    // expect(conference.keywords[0], 'Cybersecurity');
    // expect(conference.keywords[1], 'AI');
    // expect(conference.keywords[2], 'Data Science');
    // expect(conference.keywords[2], 'Logic');
  });

}