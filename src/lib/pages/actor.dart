import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/authenticate/firestoreService.dart';
import 'package:hello/authenticate/locator.dart';
import 'package:hello/classes/person.dart';
import 'package:hello/pages/keywords.dart';
import '../authenticate/authentication.dart';
import 'package:provider/provider.dart';

class Actor extends StatelessWidget {
  Atendee user;
  List<String> keywords;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Temporary landing page"),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Profile'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/create_conference');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Add conference'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              locator<FirestoreService>()
                  .getUser(FirebaseAuth.instance.currentUser.uid)
                  .then((value) {
                user = value;
              });
              /*  locator<FirestoreService>()
                  .getConferenceTags(user.conference)
                  .then((value) {
                keywords = value; 
              });*/

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => chooseKeywords(user, keywords)));
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Choose keywords'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/conference_list');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Conferences'),
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/choose_conference');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Choose Conferences'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/timetable');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Timetable'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/evaluate_interests');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Evaluate Interest'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Sign out'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            context.read<Authenticator>().signOut();
          },
        ));
  }
}
