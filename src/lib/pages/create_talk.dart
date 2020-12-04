import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/classes/person.dart';
import 'package:hello/pages/add_tags.dart';

class CreateTalk extends StatefulWidget {

final DocumentSnapshot conference;
  CreateTalk({this.conference});


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
          RegisterTalk(conference: widget.conference)
        ],
      ),
    );
  }
}

class RegisterTalk extends StatefulWidget {

  
final DocumentSnapshot conference;
  RegisterTalk({this.conference});

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
  final speakerNameController = TextEditingController();
  final speakerCVController = TextEditingController();
  final speakerLinkedinController = TextEditingController();
  List<String>tags = new List();
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              
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
=======
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
>>>>>>> development
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
                TextButton.icon(
                  onPressed: () async {
                    tags= await Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTags()));
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text('Tags: $button_tags'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: speakerNameController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Enter Speakers' name",
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                
                /*  Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: speakerLinkedinController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Enter Speakers LinkedIn",
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: speakerCVController,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      labelText: "Enter Speakers CV",
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ), */
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      

                      await databaseReference.collection("talks").doc().set({
                        "date": dateController.text,
                        "beginTime": beginTimeController.text,
                        "endTime": endTimeController.text,
                        "name": nameController.text,
                        "conference": databaseReference.doc('conference/'+widget.conference.id),
                        "tags": tags
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
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ]),
        ));
  }
}
