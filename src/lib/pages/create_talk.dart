import 'package:flutter/material.dart';

class CreateTalk extends StatefulWidget {
  @override
  _CreateTalk createState() => _CreateTalk();
}

class _CreateTalk extends State<CreateTalk> {
  String button_start_time = '';
  String button_end_time = '';
  String button_date = '';
  String button_tags = '';

  final timeController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Talk'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                dateController.text = date.toString().substring(0, 10);
                setState(() {
                  button_date = dateController.text;
                });
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Date: $button_date'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              TextButton.icon(
                onPressed: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (BuildContext context, Widget child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child,
                      );
                    },
                  );
                  timeController.text = time.format(context);
                  setState(() {
                    button_start_time = timeController.text;
                  });
                },
                icon: Icon(Icons.access_time),
                label: Text('Start Time: $button_start_time'),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  var time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  timeController.text = time.format(context);
                  setState(() {
                    button_end_time = timeController.text;
                  });
                },
                icon: Icon(Icons.access_time),
                label: Text('End Time: $button_end_time'),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ]),
            TextButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, '/add_tags');
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Tags: $button_tags'),
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
