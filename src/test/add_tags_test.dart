import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/add_tags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
 testWidgets('Add tags', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddTags(),));

    Finder tagField = find.byType(TextField);
    await tester.enterText(tagField, 'Artificial Intelligence');

    Finder button = find.byType(RaisedButton);
    await tester.tap(button);
    await tester.pump();
    final artificialIntelligenceTag = find.text('Artificial Intelligence');
    expect(artificialIntelligenceTag, findsOneWidget);
    final dataScienceTag = find.text('Data Science');
    expect(dataScienceTag, findsNothing);
  });
}