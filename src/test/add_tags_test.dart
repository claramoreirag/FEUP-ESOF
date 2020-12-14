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

    //Verifying that only the intended tag got inserted
    final artificialIntelligenceTag = find.text('Artificial Intelligence');
    expect(artificialIntelligenceTag, findsOneWidget);
    final dataScienceTag = find.text('Data Science');
    expect(dataScienceTag, findsNothing);
  });
}