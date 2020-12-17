import 'package:cloud_firestore/cloud_firestore.dart';
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
            RegisterConference(),
          ]),
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
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: confNameController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  labelText: 'Enter Conference name',
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
              SizedBox(
                height: 550,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.extended(
                    icon: Icon(Icons.playlist_add),
                    label: Text("Create Conference"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await databaseReference
                            .collection("conference")
                            .doc()
                            .set({
                          "name": confNameController.text,
                        }).then((_) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added')));
                          confNameController.clear();
                        }).catchError((onError) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(onError)));
                        });
                        Navigator.pop(context);
                      }
                    },
                  )),

            ],
          ),
        )));
  }
}
