import 'package:flutter_test/flutter_test.dart';
import 'package:hello/pages/register.dart';
import 'package:hello/classes/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Authenticator {}
class MockAttendee extends Mock implements Atendee {}


void main(){
 testWidgets('Registering as a user', (tester) async {
    // MockAuth mockAuth = MockAuth();
    // MockAttendee mockAttendee = MockAttendee();
    // when(mockAuth.currentUser).thenReturn(mockAttendee);
    // when(mockAttendee.id).thenReturn("MockID");
    // await tester.pumpWidget(MultiProvider(
    //   providers: [
    //     Provider<Authenticator>(
    //       create: (context) => mockAuth,
    //     ),
    //   ],
    //   child: MaterialApp(
    //     home: Register(),)));

    // //Entering username
    // Finder usernameField = find.byType(TextField).first;
    // await tester.enterText(usernameField, 'Random_name');

    // //Entering email
    // Finder emailField = find.byType(TextField).at(1);
    // await tester.enterText(emailField, 'test2@gmail.com');

    // //Entering password
    // Finder passwordField = find.byType(TextField).at(2);
    // await tester.enterText(passwordField, '123456');

    // //Entering location
    // Finder locationField = find.byType(TextField).at(3);
    // await tester.enterText(locationField, 'Porto');

    // //Verifying that the email has been typed
    // final email = find.text('test2@gmail.com');
    // expect(email, findsOneWidget);

    // //Verifying that the password has been typed
    // final password = find.text('123456');
    // expect(password, findsOneWidget);
  });
}