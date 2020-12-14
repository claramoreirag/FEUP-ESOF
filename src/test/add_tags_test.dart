import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/add_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main(){
 testWidgets('Adding tags as an admin', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddTags(),));

    //Entering tag 'Artificial Intelligence' into tag field
    Finder tagField = find.byType(TextField);
    await tester.enterText(tagField, 'Artificial Intelligence');

    //Tapping button to insert 'Artificial Intelligence' tag
    Finder button = find.byType(RaisedButton);
    await tester.tap(button);
    await tester.pump();

    //Verifying that the 'Artificial Intelligence' tag got selected
    final artificialIntelligenceTag = find.text('Artificial Intelligence');
    expect(artificialIntelligenceTag, findsOneWidget);

    //Verifying that the 'Data Science' tag was not selected
    await tester.enterText(tagField, 'Data Science');
    await tester.enterText(tagField, '');
    final dataScienceTag = find.text('Data Science');
    expect(dataScienceTag, findsNothing);
  });
}