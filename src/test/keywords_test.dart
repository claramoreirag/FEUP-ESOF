import 'package:flutter_test/flutter_test.dart';
import 'package:hello/view/keywords.dart';
import 'package:hello/model/person.dart' as person;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

class MockAttendee extends Mock implements person.Atendee {}

void main() {
  testWidgets('Choosing keywords as an attendee', (tester) async {
    MockAttendee mockAttendee = MockAttendee();

    await tester.pumpWidget(MaterialApp(
      home: chooseKeywords(mockAttendee, ['kw1', 'kw2', 'kw3']),
