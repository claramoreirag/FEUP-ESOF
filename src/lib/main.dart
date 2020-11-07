import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/create_conference.dart';
import 'pages/add_tags.dart';

/* import 'pages/actor.dart';

import 'pages/date_picker.dart';
import 'pages/time_picker.dart';
 */
void main() => runApp(MaterialApp(
      initialRoute: '/login',
      routes: {
        //'/actor': (context) => Actor(),
        '/login': (context) => Login(),
        '/create_conference': (context) => CreateConference(),
        '/add_tags': (context) => AddTags(),
      },
    ));
