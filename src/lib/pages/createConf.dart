import 'package:flutter/material.dart';
import 'package:hello/classes/conference.dart';

class CreateConf extends StatefulWidget {

  Conference conference;

  chooseKeywords( Conference conference) {
    this.conference = conference;
  }
  @override
  _CreateConf createState() => _CreateConf();
}

class _CreateConf extends State<CreateConf> {
  TextEditingController confNameController = TextEditingController();
  Conference conference;
  
  
  _createConf( Conference conference) {
    
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
              border: new OutlineInputBorder(
              ),
              labelText: 'Enter Conference name',
              contentPadding: EdgeInsets.all(10.0),
            ),
                     
          ), ),
          TextButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, '/create_conference');
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk '),
              style: TextButton.styleFrom(
              primary: Colors.black,
              ),
              
            ),
        ],
        ),floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Conference'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.pop(context);
          },
        ));
       

       
  }
}
