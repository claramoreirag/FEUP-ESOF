import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/classes/person.dart';
import 'package:tuple/tuple.dart';

//TODO change name to Firestore controller para parecer mais mvc

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");


  final FirebaseFirestore firestore= FirebaseFirestore.instance;
  Future createUser(Atendee user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }


/*
  Future<Atendee> getUser(String uid) async {
    try {
      Atendee atendee;
      var userData = await _usersCollectionReference.doc(uid).get().then((value) {atendee.fromData(value.data());});
      return Atendee.fromData(userData.data());
    } catch (e) {
      return e.message;
    }

  }
*/

   Future<Atendee> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return Atendee.fromData(userData.data());
    } catch (e) {
      return e.message;
    }

  } 


  Stream<QuerySnapshot>  getUserStream(String uid)  {
 
      return  _usersCollectionReference.where(FieldPath.documentId,isEqualTo:uid).snapshots();
      
  } 


/* 
  Atendee getSUser(String uid)  {
    Atendee at;
    try {
      var userData =  _usersCollectionReference.doc(uid).snapshots();
      userData.single.then((value) {at.fromData(value.data());});
    } catch (e) {
      return e.message;
    }

  } 
 */

/*   Future getConferenceTags(String confID) async{
    List<String> tags;
    QuerySnapshot snapshot=await  firestore.collection("conferece").doc(confID).collection("talks").;
    var talks=snapshot.docs;
    print(confID);
    for(var talk in talks){
      print(talk.data()["name"]);
      tags.addAll(talk.data()["tags"]);
    }
    return tags;
  }  */


  /* 
  Future getConferenceTags(String confID) async{

    QuerySnapshot snapshot=await  firestore.collection("conference").doc(confID).collection("talks").get();
     
    
    return snapshot.docs;
    
  
  } 
 */

/* 
 Future getConferenceTags(String confID)async{
   var talks = await firestore.collection("conference").doc(confID).collection("talks").get();
  List<String> keywords;
    for(var talk in talks.docs){
                     //print(docs.elementAt(i).data()['name']);
                     List<String> tags=tagsToStringList(talk.data()['tags']);
                     //print(tags);
                     //print(keywords);
                    keywords.addAll(tags);
    }
    return keywords;
 }  */
 


 Stream<QuerySnapshot> getConferenceTags(String confID){

  return firestore.collection("conference").doc(confID).collection("talks").snapshots();
     
   
 } 

 
  List<String> tagsToStringList(List<dynamic> tags){
    List<String> list= new List();
    for(int i=0; i<tags.length; i++){
      list.add(tags[i]);
  }
  return list;
  }

  setUserConference(String confID, String uid) async{
    firestore.collection("users").doc(uid).update({"conference": confID});
  }


  
  updateUser(Atendee user) async{
    firestore.collection("users").doc(user.id).update(user.toJson());
  }




Stream<QuerySnapshot> getConferenceTalks(String confID) {
  return firestore.collection("conference").doc(confID).collection("talks").snapshots();
}



addTalk({String date,String beginTime, String endTime, String name, String conference, List<String> tags})async{
await firestore.collection("conference").doc(conference).collection('talks').add({
                   "date": date,
                    "beginTime": beginTime,
                    "endTime": endTime,
                    "name": name,
                    "tags": tags      
});
}             

  // Atendee getSignedUser(String uid) {
  //   try {
  //     Atendee atendee;

  //     var userData = (_usersCollectionReference.doc(uid).get());
  //     userData.then((DocumentSnapshot) => DocumentSnapshot.data());
  //     return Atendee.fromData(userData.data());
  //   } catch (e) {
  //     return e.message;
  //   }
  // }
}
