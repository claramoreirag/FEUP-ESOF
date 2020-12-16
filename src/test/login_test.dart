import 'package:flutter_test/flutter_test.dart';
import 'package:hello/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main(){
 testWidgets('Logging in as a user', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Login(),));

    //Entering email
    Finder emailField = find.byType(TextField).first;
    await tester.enterText(emailField, 'test@gmail.com');

    //Entering password
    Finder passwordField = find.byType(TextField).last;
    await tester.enterText(passwordField, '123456');

    //Verifying that the email has been typed
    final email = find.text('test@gmail.com');
    expect(email, findsOneWidget);

    //Verifying that the password has been typed
    final password = find.text('123456');
    expect(password, findsOneWidget);
  });
}