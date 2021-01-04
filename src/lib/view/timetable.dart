import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/controller/firestoreService.dart';
import 'package:hello/controller/locator.dart';
import 'package:hello/model/person.dart';
import 'package:hello/view/choose_conference.dart';
import 'package:hello/view/create_conference.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/drawer_tile.dart';
import '../controller/authentication.dart';

import 'package:provider/provider.dart';

import 'conference_list.dart';

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
  static int i = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;
  List<BasicEvent> events;
  Atendee user;
  var smth;
  _TimetableExampleState({Atendee user}) {
    events = List();

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
      visibleRange: VisibleRange.days(3),
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
            return Scaffold(
                body: Center(
              child: Text(
                "Loading...",
                style: TextStyle(fontSize: 40, color: Colors.red[200]), 
              ),
            ));
          } else {
            if (snapshot.data.size == 0) {
              return Scaffold(
                  body: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 40, color: Colors.red[200]),
                ),
              ));
            } else {
              user = Atendee.fromData(snapshot.data.docs[0].data());
              _addEvents();

              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(''),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.today),
                      color: Colors.red[400],
                      onPressed: () => _controller.animateToToday(),
                      tooltip: 'Jump to today',
                    ),
                  ],
                ),
                body: /* Align(alignment: Alignment.center, child: Text("$smth")), */
                    Timetable<BasicEvent>(
                  controller: _controller,
                  eventBuilder: (event) {
                    return BasicEventWidget(
                      event,
                      /* onTap: () =>
                          _showSnackBar('Part-day event $event tapped'), */
                    );
                  },
                  allDayEventBuilder: (context, event, info) =>
                      BasicAllDayEventWidget(
                    event,
                    info: info,
                    //onTap: () => _showSnackBar('All-day event $event tapped'),
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
                                      width: 65, height: 65),
                                )),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Schedule IT',
                                  style: TextStyle(
                                      color: Colors.red[500], fontSize: 25.0),
                                )),
                          ],
                        )),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                          Colors.blue[300],
                          Colors.blueGrey[200]
                        ])),
                      ),
                      Drawer_Tile(Icons.person, 'Profile',
                          () => Navigator.pushNamed(context, '/profile')),
                      Drawer_Tile(
                          Icons.my_library_add,
                          'Create Conference',
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateConference(user)))),
                      Drawer_Tile(
                          Icons.list,
                          'Conferences List',
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConferenceList(user)))),
                      Drawer_Tile(Icons.my_library_add, 'Choose conference',
                          () async {
                        user = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChooseConference(user: user)));
                      }),
                      Drawer_Tile(Icons.lock, 'Logout', () => {signout()}),
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
    _eventsClear();
    _addEvent();
  }

  void _eventsClear() async {
    events.clear();
  }

  void _addEvent() async {
    smth = user.talks[0];

    for (var talk in user.talks) {
      var title = talk.name;
      var btime = talk.beginTime.split(":");
      var etime = talk.endTime.split(":");
      var date = talk.date.split("-");
      var year = int.parse(date[0]);
      var month = int.parse(date[1]);
      var day = int.parse(date[2]);
      i = i + 1;
      int btime_hour = int.parse(btime[0]);
      int btime_minutes = int.parse(btime[1]);
      int etime_hour = int.parse(etime[0]);
      int etime_minutes = int.parse(etime[1]);
      events.add(BasicEvent(
        id: i,
        title: title,
        color: Colors.blue[200],
        start: LocalDate(year, month, day)
            .at(LocalTime(btime_hour, btime_minutes, 0)),
        end: LocalDate(year, month, day)
            .at(LocalTime(etime_hour, etime_minutes, 0)),
      ));
    }
  }

  void signout() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    context.read<Authenticator>().signOut();
  }
}
