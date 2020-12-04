import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableExample extends StatefulWidget {
  @override
  _TimetableExampleState createState() => _TimetableExampleState();
}

class _TimetableExampleState extends State<TimetableExample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;
  List<BasicEvent> events;

  _TimetableExampleState() {
    events = List();
    _addEvents();
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Timetable example'),
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
            onTap: () => _showSnackBar('Part-day event $event tapped'),
          );
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () => _showSnackBar('All-day event $event tapped'),
        ),
      ),
    );
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
