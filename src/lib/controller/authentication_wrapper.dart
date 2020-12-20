import 'package:hello/model/person.dart';

import '../view/login.dart';
import '../view/timetable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:hello/controller/authentication.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Atendee user;
    final Authenticator _auth = Authenticator(FirebaseAuth.instance);

    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return TimetableExample(user: user);
    }

    return Login(title: "ScheduleIT");
  }
}
