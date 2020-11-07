/* import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Time Picker example',
      home: TimePicker(),
    );
  }
}

class TimePicker extends StatefulWidget {
  TimePicker({Key key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final timeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: TextField(
        readOnly: true,
        controller: timeController,
        decoration: InputDecoration(hintText: 'Pick your Time'),
        onTap: () async {
          var time = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          timeController.text = time.format(context);
        },
      )),
    );
  }
}
 */
