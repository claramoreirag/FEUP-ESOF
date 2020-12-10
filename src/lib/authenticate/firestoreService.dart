import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/classes/person.dart';

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




  Future getConferenceTags(String confID) async{
    List<String> tags;
    QuerySnapshot snapshot=await  firestore.collection("talks").where('conference',isEqualTo: '/conference/'+confID).get();
    var talks=snapshot.docs;
    for(var talk in talks){
      tags.addAll(talk.data()["tags"]);
    }
    return tags;
  } 

  setUserConference(String confID, String uid) async{
    firestore.collection("users").doc(uid).update({"conference": confID});
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
