import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateTalk extends StatefulWidget {
  @override
  _CreateTalk createState() => _CreateTalk();
}

class _CreateTalk extends State<CreateTalk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talk'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          RegisterTalk(),
        ],
      ),
    );
  }
}

class RegisterTalk extends StatefulWidget {
  @override
  _RegisterTalk createState() => _RegisterTalk();
}

class _RegisterTalk extends State<RegisterTalk> {
  final _formKey = GlobalKey<FormState>();

  String button_start_time = '';
  String button_end_time = '';
  String button_date = '';
  String button_tags = '';

  final databaseReference = FirebaseFirestore.instance;
  final dbRef = FirebaseDatabase.instance.reference().child("talks");
  final beginTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final dateController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: 'Enter Talk name',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
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
                      );
                      beginTimeController.text = time.format(context);
                      setState(() {
                        button_start_time = beginTimeController.text;
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
                      endTimeController.text = time.format(context);
                      setState(() {
                        button_end_time = endTimeController.text;
                      });
                    },
                    icon: Icon(Icons.access_time),
                    label: Text('End Time: $button_end_time'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                  ),
                ]),
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      /*  dbRef.push().set({
                        "date": dateController.text,
                        "beginTime": beginTimeController.text,
                        "endTime": endTimeController.text,
                        "name": nameController.text,
                      }).then((_) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Successfully Added')));
                        beginTimeController.clear();
                        endTimeController.clear();
                        nameController.clear();
                        dateController.clear();
                      }).catchError((onError) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(onError)));
                      }); */

                      await databaseReference.collection("talks").doc().set({
                        "date": dateController.text,
                        "beginTime": beginTimeController.text,
                        "endTime": endTimeController.text,
                        "name": nameController.text,
                      }).then((_) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Successfully Added')));
                        beginTimeController.clear();
                        endTimeController.clear();
                        nameController.clear();
                        dateController.clear();
                      }).catchError((onError) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(onError)));
                      });
                    }
                  },
                  child: Text('Add'),
                ),
              ]),
        ));
  }
}
