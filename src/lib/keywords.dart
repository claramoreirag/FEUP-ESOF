import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'tags.dart';
import 'person.dart';
import 'conference.dart';


//TODO: alter color after pressed 
Widget getButtonsKeywords(List<String> keywords, User user){ //buttons with keywords
  List<Widget> list = new List<Widget>();
  for(var i = 0; i < keywords.length; i++){
    list.add(Expanded(
      child: new RaisedButton(
            onPressed: (){
            user.addInterest(keywords[i]);
            },
            color: Colors.indigo,
            child: Container(
              child: Center(child: Text(keywords[i]),),

      
              

            ),
            textColor: Colors.white,
            padding: EdgeInsets.all(30.0),
            )
    ));
  }
  return new Column(children : list, crossAxisAlignment: CrossAxisAlignment.stretch,);
}

Widget printList(List<String> lst){
  List<Widget> list = new List<Widget>();
  for(var i = 0; i < lst.length; i++){
    list.add(new Text(lst[i]));
  }
  return new Row(children : list);
}

class chooseKeywords extends StatelessWidget {
  User user;
  Conference conference;

  chooseKeywords(User user, Conference conference){
    this.user = user;
    this.conference = conference;
  }

  @override
  Widget build(BuildContext context) {

    //List<String> keywords = this.conference.addKeywords();
    List<String> keywords = ["AI", "CyberSecurity", "Computer Graphics", "Computer Networks", "Data Mining"];
    //TODO: Add app bar
    return Scaffold(
      body: SafeArea(
        child: getButtonsKeywords(keywords, user),
        left: true,
        right: true,
        bottom: true,
        top: true,
      ),
    );
  }
}
