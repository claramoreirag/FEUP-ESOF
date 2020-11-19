import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'classes/tags.dart';
import 'classes/person.dart';
import 'classes/conference.dart';

void printList(List<String> lst) {
  print("List size: ");
  print(lst.length);
  for (var i = 0; i < lst.length; i++) {
    print(lst[i]);
  }
}

class chooseKeywords extends StatefulWidget {
  User user;
  Conference conference;

  chooseKeywords(User user, Conference conference) {
    this.user = user;
    this.conference = conference;
  }

  @override
  _chooseKeywords createState() => _chooseKeywords(user, conference);
}

class _chooseKeywords extends State<chooseKeywords> {
  User user;
  Conference conference;
  bool indigo;
  bool checkboxValue = false;
  List<String> keywords = [
    "AI",
    "CyberSecurity",
    "Computer Graphics",
    "Computer Networks",
    "Data Mining"
  ];
  Map<String, bool> values;

  _chooseKeywords(User user, Conference conference) {
    this.user = user;
    this.conference = conference;
    this.values = mapValues(keywords);
  }

  Map<String, bool> mapValues(List<String> keywords) {
    Map<String, bool> map = Map<String, bool>();
    for (int i = 0; i < keywords.length; i++) {
      map[keywords[i]] = false;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    //List<String> keywords = this.conference.addKeywords();

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose your interests"),
      ),
      body: SafeArea(
          child: ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
                if (value)
                  user.addInterest(key);
                else
                  user.removeInterest(key);

              });
            },
          );
        }).toList(),
      )),
    );
  }
}

class evaluatesInterests extends StatefulWidget {
  User user;


  evaluatesInterests(User user) {
    this.user = user;

  }

  @override
  _evaluatesInterests createState() => _evaluatesInterests(user);
}

class _evaluatesInterests extends State<evaluatesInterests> {
  User user;
  Map<String, int> map;

  _evaluatesInterests(User user) {
    this.user = user;
    this.map = Map<String, int>();
  }

  Widget getDropdownButton(){
    List<Widget> lista = [];
    for(int i = 0; i < user.interests.length; i++){
      lista.add(new Row(
        children: <Widget>[
          new Text(user.interests[i]),
          new DropdownButton<int>(
            items: <int>[1,2,3,4,5].map((int value){
              return new DropdownMenuItem<int>(
                value: value,
                child: new Text(value.toString()),
              );
            }
            ).toList(),
            onChanged: (int value){
              setState(() {
                map[user.interests[i]] = value;
              });
            },
            focusColor: Colors.blue[100],
          ),
        ]
      ));
    }

    this.user.orderInterestsByPriority(map); // TODO mudar isto do sítio
    printList(this.user.interests);
    return new Column(children: lista);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Evaluate your interests from 1 to 5"),
        ),
        body: SafeArea(
            child: getDropdownButton()
        )
    );
  }
}


