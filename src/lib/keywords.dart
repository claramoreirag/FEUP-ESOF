import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/model/person.dart';
import 'package:hello/model/talk.dart';
import 'controller/firestoreService.dart';
import 'controller/locator.dart';
import 'model/conference.dart';

void printList(List<String> lst) {
  print("List size: ");
  print(lst.length);
  for (var i = 0; i < lst.length; i++) {
    print(lst[i]);
  }
}

class chooseKeywords extends StatefulWidget {
  Atendee user;

  chooseKeywords({Atendee user}) {
    this.user = user;
  }

  @override
  _chooseKeywords createState() => _chooseKeywords(user: this.user);
}

class _chooseKeywords extends State<chooseKeywords> {
  Atendee user;

  List<String> keywords = new List();
  Map<String, bool> values = new Map();

  _chooseKeywords({Atendee user, Conference conference}) {
    this.user = user;
    this.keywords = new List();
    this.values = new Map();
    //this.conference = conference;
    //this.values = mapValues(keywords);
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose your interests"),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: locator<FirestoreService>()
                  .getConferenceTags(user.conference),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("Loading..."),
                  );
                } else {
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  if (keywords.length <= 0) {
                    for (int i = 0; i < docs.length; i++) {
                      List<String> tags =
                          tagsToStringList(docs.elementAt(i).data()['tags']);
                      keywords.addAll(tags);
                    }
                  }

                  values = mapValues(keywords);
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return ListView(
                      children: values.keys.map((String key) {
                        return CheckboxListTile(
                          title: new Text(key),
                          value: values[key],
                          onChanged: (bool value) {
                            setState(() {
                              values[key] = value;
                              print(values);
                              if (value) {
                                user.addInterest(key);
                                locator<FirestoreService>().updateUser(user);
                              } else {
                                user.removeInterest(key);
                                locator<FirestoreService>().updateUser(user);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  });
                }
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('OK'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => evaluatesInterests(user)));
          },
        ));
  }

  List<String> tagsToStringList(List<dynamic> tags) {
    List<String> list = new List();
    for (int i = 0; i < tags.length; i++) {
      list.add(tags[i]);
    }
    return list;
  }
}

class evaluatesInterests extends StatefulWidget {
  Atendee user;

  evaluatesInterests(Atendee user) {
    this.user = user;
  }

  @override
  _evaluatesInterests createState() => _evaluatesInterests(user);
}

class _evaluatesInterests extends State<evaluatesInterests> {
  Atendee user;
  Map<String, int> map = new Map();
  Map<String, int> dropdownValues = new Map();

  _evaluatesInterests(Atendee user) {
    this.user = user;
    this.map = Map<String, int>();
    for (int i = 0; i < user.interests.length; i++) {
      dropdownValues[user.interests[i]] = 1;
      map[user.interests[i]] = 1;
    }
/*     this.user.addInterest('Computer Science');
    this.user.addInterest('AI'); */
  }

  Widget getDropdownButton() {
    print(user.interests.toString());
    List<Widget> lista = [];
    for (int i = 0; i < user.interests.length; i++) {
      lista.add(Row(children: <Widget>[
        SizedBox(width: 15),
        Text(user.interests[i]),
        SizedBox(width: 10),
        DropdownButton<int>(
          elevation: 16,
          iconEnabledColor: Colors.lightBlue,
          underline: Container(
            height: 2,
            color: Colors.lightBlue,
          ),
          value: dropdownValues[user.interests[i]],
          items: <int>[1, 2, 3, 4, 5].map((int value) {
            return new DropdownMenuItem<int>(
              value: value,
              child: new Text(value.toString()),
            );
          }).toList(),
          onChanged: (int value) {
            locator<FirestoreService>().updateUser(user);
            setState(() {
              map[user.interests[i]] = value;
              dropdownValues[user.interests[i]] = value;
            });
          },
          focusColor: Colors.blue[100],
        ),
      ]));
    }

    this.user.orderInterestsByPriority(map);
    //printList(this.user.interests);
    return new Column(children: lista);
  }

  List<Talk> conferenceTalks = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Evaluate your interests from 1 to 5"),
        ),
        body: SafeArea(child: getDropdownButton()),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text('OK'),
          icon: Icon(Icons.playlist_add_check_rounded),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => scheduleMaking(user)));
          },
        ));
  }

  Widget talksCalculation() {
    return SafeArea(
      child: FutureBuilder(
          future: locator<FirestoreService>()
              .getListTalks(user.conference)
              .then((value) {
            conferenceTalks = value;
          }),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Calculating your preferred talks..."),
              );
            } else {
              print('hehehehe ' + conferenceTalks[0].tags.toString());
              Navigator.pop(context, user);
              return Center(child: Text("Your schedule is ready!"));
            }
          }),
    );
  }
}

class scheduleMaking extends StatefulWidget {
  Atendee user;

  scheduleMaking(Atendee user) {
    this.user = user;
  }

  @override
  _scheduleMaking createState() => _scheduleMaking(user);
}

class _scheduleMaking extends State<scheduleMaking> {
  Atendee user;

  _scheduleMaking(Atendee user) {
    this.user = user;
  }
  List<Talk> conferenceTalks = new List();
  Widget talksCalculation() {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: StreamBuilder(
                stream: locator<FirestoreService>()
                    .getConferenceTalks(user.conference),
                builder: (_, snapshot) {
                  if (!snapshot.hasData || snapshot.data.size == 0) {
                    return Center(
                      child: Text("Calculating your preferred talks..."),
                    );
                  } else {
                    print(snapshot.data.docs);
                    var docs = snapshot.data.docs;
                    conferenceTalks = new List();
                    for (int i = 0; i < docs.length; i++) {
                      Talk talk = Talk.fromData(docs[i].data());
                      conferenceTalks.add(talk);
                      print(conferenceTalks.length);
                    }
                    user.selectTalksToAttend(conferenceTalks);
                    for (var talk in user.talks) print(talk.name);
                    print(user.talks.toString());
                    locator<FirestoreService>().updateUser(user);
                    return Center(
                      child: Text(
                        "Your schedule is ready!",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                })),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton.extended(
          // isExtended: true,
          label: Text("OK"),
          icon: Icon(Icons.check),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.pushNamed(context, '/timetable');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return talksCalculation();
  }
}
