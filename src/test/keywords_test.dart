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
    ));

    var checkboxKeyword1 = find.byType(CheckboxListTile).first;

    //Adding first interest
    when(mockAttendee.interests).thenReturn(['kw1']);
    await tester.tap(checkboxKeyword1);
    await tester.pump();

    //Verifying only the first interest was checked
    verify(mockAttendee.addInterest('kw1')).called(1);
    verifyNever(mockAttendee.addInterest('kw2'));
    verifyNever(mockAttendee.addInterest('kw3'));

    //Removing first interest
    await tester.tap(checkboxKeyword1);
    await tester.pump();

    //Verifying only the first interest was removed
    verify(mockAttendee.removeInterest('kw1')).called(1);
    verifyNever(mockAttendee.removeInterest('kw2'));
    verifyNever(mockAttendee.removeInterest('kw3'));
  });
}
