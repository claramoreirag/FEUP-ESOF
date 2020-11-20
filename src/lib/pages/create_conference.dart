import 'package:flutter/material.dart';
import 'package:hello/classes/conference.dart';

class CreateConference extends StatefulWidget {
  Conference conference;

  @override
  _CreateConference createState() => _CreateConference(conference);
}

class _CreateConference extends State<CreateConference> {
  TextEditingController confNameController = TextEditingController();
  Conference conference;
  chooseKeywords(Conference conference) {
    this.conference = conference;
  }

  _CreateConference(Conference conference) {
    this.conference = conference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Conference'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: TextFormField(
                controller: confNameController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  labelText: 'Enter Conference name',
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, '/create_talk');
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk '),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Conference'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.pop(context);
          },
        ));
  }
}
