import 'package:flutter_test/flutter_test.dart';
import 'package:hello/pages/create_conference.dart';
import 'package:flutter/material.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Authenticator {}


void main(){
 testWidgets('Creating a conference as an admin', (tester) async {
 	//TO DO: Needs database
 	// MockAuth mockAuth = MockAuth();
  //   await tester.pumpWidget(MultiProvider(
  //     providers: [
  //       Provider<Authenticator>(
  //         create: (context) => mockAuth,
  //       ),
  //     ],
  //     child: MaterialApp(
  //       home: CreateConference(),)));


    
  });
}