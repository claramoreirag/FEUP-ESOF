import 'package:flutter/material.dart';

class CreateConference extends StatefulWidget {
  @override
  _CreateConference createState() => _CreateConference();
}

class _CreateConference extends State<CreateConference> {
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talk'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          FlatButton.icon(
            onPressed: () async {
              var time = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              timeController.text = time.format(context);
            },
            icon: Icon(Icons.access_time),
            label: Text('Pick your time'),
          ),
          FlatButton.icon(
            onPressed: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));
              dateController.text = date.toString().substring(0, 10);
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Pick your date'),
          ),
          FlatButton.icon(
            onPressed: () async {
              Navigator.pushNamed(context, '/add_tags');
            },
            icon: Icon(Icons.calendar_today),
            label: Text('Pick your tags'),
          ),
        ],
      )),
    );
  }
}
