import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hello/classes/conference.dart';

import 'create_talk.dart';

class ConferenceList extends StatefulWidget {
   

  @override
  _ConferenceList createState() => _ConferenceList();
}

class _ConferenceList extends State<ConferenceList> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Conferences'),
          centerTitle: true,
        ),
        body: ListPage(),
          
         
        );
  }
}



class ListPage extends StatefulWidget {
   
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  Future<void> getConferences() async {
    var dbref=FirebaseFirestore.instance;
    QuerySnapshot queryConfs= await dbref.collection("conference").get();
    return queryConfs.docs;
  }


  navigateToDetail(DocumentSnapshot conference){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>ConferencePage(conference:conference) ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getConferences(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: Text("Loading..."),);
        }else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(_,index){
              return ListTile(
                title:Text(snapshot.data[index]["name"]),
                onTap: ()=> navigateToDetail(snapshot.data[index]));
            } ,);
        }
      }),);
  }

}




class ConferencePage extends StatefulWidget {
   
  final DocumentSnapshot conference;
  ConferencePage({this.conference});

  @override
  _ConferencePage createState() => _ConferencePage();
}

class _ConferencePage extends State<ConferencePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.conference["name"]),
          centerTitle: true,
        ),
        body: 
         Column(
           children: [
           TextButton.icon(
              onPressed: () async {
                
                Navigator.push(context,MaterialPageRoute(builder:(context)=> CreateTalk(conference: widget.conference)));
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Add talk '),
              style: TextButton.styleFrom(
                primary: Colors.black,
              )),],
           
         )
         
        );
  }
  
}