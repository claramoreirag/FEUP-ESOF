import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'authenticate/authentication.dart';
import 'pages/login.dart';
import 'pages/create_conference.dart';
import 'pages/add_tags.dart';

/* import 'pages/actor.dart';

import 'pages/date_picker.dart';
import 'pages/time_picker.dart';
 */

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
        //home: AuthenticationWrapper(),
      )

    );   
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key,}) : super(key : key);

  @override
  Widget build(BuildContext context){
    final firebaseUser =  context.watch<User>();

    if(firebaseUser != null){
      return AddTags();
    }
    return Login();
  }

}
