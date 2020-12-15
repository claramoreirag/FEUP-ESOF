import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/authenticate/firestoreService.dart';
import 'package:hello/authenticate/locator.dart';
import 'package:hello/classes/person.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/drawer_tile.dart';
import '../authenticate/authentication.dart';

import 'package:provider/provider.dart';

import '../keywords.dart';

class TimetableExample extends StatefulWidget {
  Atendee user;

  TimetableExample({Atendee user}) {
    this.user = user;
  }

  @override
  _TimetableExampleState createState() =>
      _TimetableExampleState(user: this.user);
}

class _TimetableExampleState extends State<TimetableExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;
  List<BasicEvent> events;
  Atendee user;
  _TimetableExampleState({Atendee user}) {
    events = List();
    _addEvents();
    this.user = user;
  }

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      // A basic EventProvider containing a single event:
      eventProvider: EventProvider.list(events),

      // Other (optional) parameters:
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(5),
      firstDayOfWeek: DayOfWeek.monday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: locator<FirestoreService>()
            .getUserStream(FirebaseAuth.instance.currentUser.uid),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            if (snapshot.data.size == 0) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              user = Atendee.fromData(snapshot.data.docs[0].data());

              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(''),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.today),
                      onPressed: () => _controller.animateToToday(),
                      tooltip: 'Jump to today',
                    ),
                  ],
                ),
                body: Timetable<BasicEvent>(
                  controller: _controller,
                  eventBuilder: (event) {
                    return BasicEventWidget(
                      event,
                      onTap: () =>
                          _showSnackBar('Part-day event $event tapped'),
                    );
                  },
                  allDayEventBuilder: (context, event, info) =>
                      BasicAllDayEventWidget(
                    event,
                    info: info,
                    onTap: () => _showSnackBar('All-day event $event tapped'),
                  ),
                ),
                drawer: Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Material(
                                elevation: 10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image.asset("images/logo.png",
                                      width: 80, height: 80),
                                )),
                            Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  'Schedule IT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0),
                                )),
                          ],
                        )),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                          Colors.blue[800],
                          Colors.blue
                        ])),
                      ),
                      Drawer_Tile(Icons.person, 'Profile',
                          () => Navigator.pushNamed(context, '/profile')),
                      Drawer_Tile(
                          Icons.my_library_add,
                          'Create Conference',
                          () => Navigator.pushNamed(
                              context, '/create_conference')),
                      Drawer_Tile(Icons.import_contacts, 'Choose Interests',
                          () async {
                        user = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    chooseKeywords(user: user)));
                      }),
                      Drawer_Tile(
                          Icons.list,
                          'Conferences List',
                          () =>
                              Navigator.pushNamed(context, '/conference_list')),
                      Drawer_Tile(Icons.lock, 'Logout',
                          () => {context.read<Authenticator>().signOut()}),
                      Drawer_Tile(
                          Icons.my_library_add,
                          'Choose conference',
                          () => Navigator.pushNamed(
                              context, '/choose_conference')),
                      Drawer_Tile(
                          Icons.import_contacts,
                          'Evaluate Interests',
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      evaluatesInterests(user))))
                    ],
                  ),
                ),
              );
            }
          }
        });
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }

  void _addEvents() async {
    //buscar coisas bonitas da BD
    _addEvent();
  }

  void _addEvent() async {
    events.add(BasicEvent(
      id: 1,
      title: 'My Event1',
      color: Colors.red,
      start: LocalDate.today().at(LocalTime(16, 0, 0)),
      end: LocalDate.today().at(LocalTime(17, 0, 0)),
    ));

    events.add(BasicEvent(
      id: 2,
      title: 'My Event2',
      color: Colors.red,
      start: LocalDate.today().at(LocalTime(12, 0, 0)),
      end: LocalDate.today().at(LocalTime(16, 0, 0)),
    ));

    var dbref = FirebaseFirestore.instance;
    QuerySnapshot queryTalks = await dbref.collection("talks").get();
    var talks = queryTalks.docs;
    var i = 0;
    for (var talk in talks) {
      var title = talk['name'];
      var btime = talk['beginTime'];
      var etime = talk['endTime'];
      //var date = talk['date'];
      events.add(BasicEvent(
        id: i,
        title: title,
        color: Colors.red,
        start: btime,
        end: etime,
      ));
    }
    i++;
  }
}
