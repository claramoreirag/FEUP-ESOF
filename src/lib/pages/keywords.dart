import 'package:flutter/material.dart';
import 'package:hello/classes/person.dart';
import '../classes/conference.dart';

void printList(List<String> lst) {
  print("List size: ");
  print(lst.length);
  for (var i = 0; i < lst.length; i++) {
    print(lst[i]);
  }
}

class chooseKeywords extends StatefulWidget {
  Atendee user;
  Conference conference;

  chooseKeywords(Atendee user, Conference conference) {
    this.user = user;
    this.conference = conference;
  }

  @override
  _chooseKeywords createState() => _chooseKeywords(this.user, this.conference);
}

class _chooseKeywords extends State<chooseKeywords> {
  Atendee user;
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

  _chooseKeywords(Atendee user, Conference conference) {
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
                printList(user.interests);
              });
            },
          );
        }).toList(),
      )),
    );
  }
}
