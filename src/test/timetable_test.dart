import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hello/pages/timetable.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockAuth extends Mock implements Authenticator {}

void main(){
  testWidgets('Timetable widget', (tester) async {
  	// ASKS FOR DATABASE
    // MockAuth mockAuth = MockAuth();
    // await tester.pumpWidget(MultiProvider(
    //   providers: [
    //     Provider<Authenticator>(
    //       create: (context) => mockAuth,
    //     ),
    //   ],
    //   child: MaterialApp(
    //     home: TimetableExample(),)));


    // final text = find.text('Your Timetable');

    // expect(text, findsOneWidget);

  });
}