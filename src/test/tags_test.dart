import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello/model/tags.dart' as our;

void main() {
  test('Tags class test', () {
    our.Tags tag1 = our.Tags(id: 1, title: 'Tag1');
    our.Tags tag2 = our.Tags(id: 2, title: 'Tag2');
    our.Tags tag3 = our.Tags(id: 3, title: 'Tag3');
    our.Tags tag4 = our.Tags(id: 4, title: 'Tag4');

    expect(tag1.toMap()['id'], 1);
    expect(tag1.toMap()['title'], 'Tag1');

    expect(tag2.toMap()['id'], 2);
    expect(tag2.toMap()['title'], 'Tag2');

    expect(tag3.toMap()['id'], 3);
    expect(tag3.toMap()['title'], 'Tag3');

    expect(tag4.toMap()['id'], 4);
    expect(tag4.toMap()['title'], 'Tag4');
  });
}
