import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'authenticate/authentication.dart';
import 'authenticate/authentication_wrapper.dart';
import 'pages/login.dart';
import 'pages/create_conference.dart';
import 'pages/add_tags.dart';
import 'keywords.dart';
import 'classes/person.dart';
import 'classes/conference.dart';

/* import 'pages/actor.dart';
import 'pages/date_picker.dart';
import 'pages/time_picker.dart';
 */

/*
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
} 

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<Authenticator>(
          create: (_) => Authenticator(FirebaseAuth.instance),
          ),//Provider
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
          //'/actor': (context) => Actor(),
          '/authentication': (context) => AuthenticationWrapper(),
          '/create_conference': (context) => CreateConference(),
          '/add_tags': (context) => AddTags(),
        },
      )
    );
  }
}
*/

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    User temp = new User(1, "leonor", "leonor.gomes@gmail.com", "1234");
    temp.addInterest("Science");
    temp.addInterest("Math");
    temp.addInterest("Kittens");
    return MaterialApp(
      title: 'Flutter Time Picker example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Login(title: 'Schedule IT'),
      home: evaluatesInterests(temp),
    );
  }

}