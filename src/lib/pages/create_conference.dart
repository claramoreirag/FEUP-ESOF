import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hello/classes/conference.dart';

class CreateConference extends StatefulWidget {
   Conference conference;

  @override
  _CreateConference createState() => _CreateConference();
}

class _CreateConference extends State<CreateConference> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Conference'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          RegisterConference(),]
          
        ),
        
        );
  }
}



class RegisterConference extends StatefulWidget {
  @override
  _RegisterConference createState() => _RegisterConference();
}

class _RegisterConference extends State<RegisterConference> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController confNameController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
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
            /* TextButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, '/create_talk');
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk '),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ), 
            
            ),*/ RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
           await databaseReference.collection("conference").doc().set({
                        "name": confNameController.text,
                      }).then((_) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Successfully Added')));
                        confNameController.clear();
                      }).catchError((onError) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(onError)));
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
          )],),
        ));
  }
}
