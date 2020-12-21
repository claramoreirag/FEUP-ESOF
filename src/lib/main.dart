import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/controller/locator.dart';
import 'package:hello/view/choose_conference.dart';
import 'package:provider/provider.dart';
import 'package:hello/controller/authentication.dart';
import 'package:hello/controller/authentication_wrapper.dart';
import 'package:hello/view/view_profile.dart';
import 'package:hello/view/create_talk.dart';
import 'package:hello/view/add_tags.dart';
import 'package:hello/view/timetable.dart';
import 'package:hello/view/register.dart';
import 'package:hello/model/conference.dart';
import 'package:hello/model/person.dart';
import 'package:hello/view/keywords.dart';

Future<void> main() async {
  begin();
}

Future<void> begin() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    Atendee user = new Atendee(
        id: '1', fullName: "leonor", email: "leonor.gomes@gmail.com");
    Conference conference = new Conference();

    return MultiProvider(
        providers: [
          Provider<Authenticator>(
            create: (_) => Authenticator(FirebaseAuth.instance),
          ), //Provider
          StreamProvider(
            create: (context) => context.read<Authenticator>().authStateChanges,
          )
        ],
        child: MaterialApp(
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child),
          title: 'Flutter Time Picker example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/authentication',
          routes: {
            '/timetable': (context) => TimetableExample(),
            '/authentication': (context) => AuthenticationWrapper(),
            '/profile': (context) => ViewProfile(),
            '/create_talk': (context) => CreateTalk(),
            '/add_tags': (context) => AddTags(),
            '/choose_conference': (context) => ChooseConference(),
            '/evaluate_interests': (context) => evaluatesInterests(user),
            '/register': (context) => Register(),
          },
        ));
  }
}
