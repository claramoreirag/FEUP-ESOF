import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/pages/create_conference.dart';
import 'package:provider/provider.dart';
import 'authenticate/authentication.dart';
import 'authenticate/authentication_wrapper.dart';
import 'pages/view_profile.dart';
import 'pages/create_talk.dart';
import 'pages/add_tags.dart';
import 'pages/actor.dart';
import 'classes/conference.dart';
import 'classes/person.dart';
import 'keywords.dart';

/* import 'pages/actor.dart';
import 'pages/date_picker.dart';
import 'pages/time_picker.dart';
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    Atendee user;
    Conference conference;
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
          title: 'Flutter Time Picker example',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/authentication',
          routes: {
            '/authentication': (context) => AuthenticationWrapper(),
            '/profile': (context) => ViewProfile(),
            '/actor': (contect) => Actor(),
            '/create_talk': (context) => CreateTalk(),
            '/add_tags': (context) => AddTags(),
            '/create_conference': (context) => CreateConference(),
            '/choose_keywords': (context) => chooseKeywords(user, conference),
            '/register': (context) => Register(),

          },
        ));
  }
}
