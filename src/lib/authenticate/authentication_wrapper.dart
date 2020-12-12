import 'package:hello/authenticate/firestoreService.dart';
import 'package:hello/authenticate/locator.dart';
import 'package:hello/classes/person.dart';

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
    Atendee user;
    final Authenticator _auth = Authenticator(FirebaseAuth.instance);

    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
     
                  
        return TimetableExample(user:user);
    }
    
    return Login(title: "ScheduleIT");
  }
}
