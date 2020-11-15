import 'package:flutter/material.dart';

class CreateConf extends StatefulWidget {
  @override
  _CreateConf createState() => _CreateConf();
}

class _CreateConf extends State<CreateConf> {
  String button_start_time = '';
  String button_end_time = '';
  String button_date = '';
  String button_tags = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Conference'),
         
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            
            TextButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, '/create_conference');
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk: $button_tags'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Talk'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.pop(context);
          },
        ));
  }
}
