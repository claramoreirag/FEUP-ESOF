import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello/pages/create_talk.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:hello/authenticate/firestoreService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';


class MockAuth extends Mock implements Authenticator {}
class MockFirestore extends Mock implements FirestoreService {}



void main(){
  testWidgets('Creating a talk as an admin', (tester) async {
    // MockAuth mockAuth = MockAuth();
    // MockFirestore mockFirestore = MockFirestore();
    // await tester.pumpWidget(MultiProvider(
    //   providers: [
    //     Provider<Authenticator>(
    //       create: (context) => mockAuth,
    //     ),
    //   ],
    //   child: MaterialApp(
    //     home: CreateTalk(),)));

    // //TODO: improve comments

    // //Talk Name
    // //Entering a name to the talk being created
    // Finder talkNameField = find.byType(TextFormField).first;
    // await tester.enterText(talkNameField, 'Random Talk Name');

    // //Date
    // //Tapping button to open calendar
    // var openCalendarButton = find.byType(TextButton).first;
    // await tester.tap(openCalendarButton);
    // await tester.pump();
    // //Choosing today's date as talk's date
    // Finder chooseDateButton = find.text('OK');
    // await tester.tap(chooseDateButton);
    // await tester.pump();

    // //Start Time
    // //Tapping button to open start time
    // var openStartTimeButton = find.byType(TextButton).at(1);
    // await tester.tap(openStartTimeButton);
    // await tester.pump();
    // //Choosing current time as talk's start time
    // Finder chooseStartTimeButton = find.text('OK');
    // await tester.tap(chooseStartTimeButton);
    // await tester.pump();

    // //End Time
    // //Tapping button to open end time
    // var openEndTimeButton = find.byType(TextButton).at(2);
    // await tester.tap(openEndTimeButton);
    // await tester.pump();
    // //Choosing current time as talk's end time
    // Finder chooseEndTimeButton = find.text('OK');
    // await tester.tap(chooseEndTimeButton);
    // await tester.pump();

    // //Tags
    // //Tapping button to open tags choice
    // var openTagsButton = find.byType(TextButton).last;
    // await tester.tap(openTagsButton);
    // await tester.pump();
    // //Tapping button to close tags choice
    // Finder closeTagsButton = find.byType(MaterialPageRoute);
    // await tester.tap(closeTagsButton);
    // await tester.pump();

    // //Speakers' Names
    // //Entering talk's speakers' names
    // Finder speakersNameField = find.byType(TextFormField).last;
    // await tester.enterText(talkNameField, 'Random Speaker Name');

    // //Tapping "Add" button at the bottom of the page to enter talk
    // Finder addTalkButton = find.byType(RaisedButton);
    // await tester.tap(addTalkButton);
    // await tester.pump();


    // //TODO: have some kind of confirmation
    // //Verifying that the Talk was created successfully
    // // final successConfirmation = find.text('Successfully Added');
    // // expect(successConfirmation, findsOneWidget);

  });
}