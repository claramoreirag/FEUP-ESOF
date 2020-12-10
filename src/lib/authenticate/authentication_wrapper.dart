import '../pages/login.dart';
import '../pages/timetable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:hello/authenticate/authentication.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Authenticator _auth = Authenticator(FirebaseAuth.instance);

    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return TimetableExample();
    }
    return Login(title: "ScheduleIT");
  }
}
