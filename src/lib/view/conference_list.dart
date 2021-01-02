import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/controller/firestoreService.dart';
import 'package:hello/controller/locator.dart';
import 'package:hello/model/person.dart';
import 'create_talk.dart';

class ConferenceList extends StatefulWidget {
  Atendee user;
  ConferenceList(Atendee user) {
    this.user = user;
  }
  @override
  _ConferenceList createState() => _ConferenceList(user);
}

class _ConferenceList extends State<ConferenceList> {
  Atendee user;
  _ConferenceList(Atendee user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conferences'),
        centerTitle: true,
      ),
      body: ListPage(user),
    );
  }
}

class ListPage extends StatefulWidget {
  Atendee user;
  ListPage(Atendee user) {
    this.user = user;
  }
  @override
  _ListPage createState() => _ListPage(user);
}

class _ListPage extends State<ListPage> {
  Atendee user;
  _ListPage(Atendee user) {
    this.user = user;
  }

  Future<void> getConferences() async {
    var dbref = FirebaseFirestore.instance;
    QuerySnapshot queryConfs = await dbref.collection("conference").get();
    return queryConfs.docs;
  }

  navigateToDetail(DocumentSnapshot conference) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConferencePage(conference: conference)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder(
          future: locator<FirestoreService>().getUserConferences(user.id),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                      title: Text(snapshot.data[index]["name"]),
                      onTap: () => navigateToDetail(snapshot.data[index]));
                },
              );
            }
          }),
    );
  }
}

class ConferencePage extends StatefulWidget {
  final DocumentSnapshot conference;
  ConferencePage({this.conference});

  @override
  _ConferencePage createState() => _ConferencePage(conference: conference);
}

class _ConferencePage extends State<ConferencePage> {
  final DocumentSnapshot conference;
  _ConferencePage({this.conference});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.conference["name"]),
          centerTitle: true,
        ),
        body: Column(children: [
          TextButton.icon(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateTalk(conference: widget.conference)));
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk '),
              style: TextButton.styleFrom(
                primary: Colors.black,
              )),
          /*  ListTalks(
            conference: conference,
          ) */
        ]));
  }
}

class ListTalks extends StatefulWidget {
  final DocumentSnapshot conference;
  ListTalks({this.conference});
  @override
  _ListTalks createState() => _ListTalks();
}

class _ListTalks extends State<ListTalks> {
  Future<void> getTalks() async {
    var dbref = FirebaseFirestore.instance;
    QuerySnapshot queryTalks = await dbref
        .collection("conference")
        .where('conference', isEqualTo: ('/conference/' + widget.conference.id))
        .get();
    return queryTalks.docs;
  }

  navigateToDetail(DocumentSnapshot conference) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConferencePage(conference: conference)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: locator<FirestoreService>()
              .getConferenceTalks(widget.conference.id),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.size,
                itemBuilder: (_, index) {
                  return ListTile(title: Text(snapshot.data[index]["name"]));
                  //onTap: ()=> navigateToDetail(snapshot.data[index]));
                },
              );
            }
          }),
    );
  }
}
