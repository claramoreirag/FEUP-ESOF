import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/classes/conference.dart';
import 'package:hello/classes/person.dart';
import 'package:hello/classes/talk.dart';
import 'package:tuple/tuple.dart';

//TODO change name to Firestore controller para parecer mais mvc

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  Stream<QuerySnapshot> getUserStream(String uid) {
    return _usersCollectionReference
        .where(FieldPath.documentId, isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getConferenceTags(String confID) {
    return firestore
        .collection("conference")
        .doc(confID)
        .collection("talks")
        .snapshots();
  }

  List<String> tagsToStringList(List<dynamic> tags) {
    List<String> list = new List();
    for (int i = 0; i < tags.length; i++) {
      list.add(tags[i]);
    }
    return list;
  }

  setUserConference(String confID, String uid) async {
    firestore.collection("users").doc(uid).update({"conference": confID});
  }

  updateUser(Atendee user) async {
    firestore.collection("users").doc(user.id).update(user.toJson());
    firestore
        .collection("users")
        .doc(user.id)
        .update({"talks": FieldValue.delete()});
    List<Map<String, dynamic>> dbtalks = new List();
    if (user.talks.length > 0) {
      for (Talk talk in user.talks) {
        dbtalks.add(talk.toJson());
      }
      firestore.collection("users").doc(user.id).update({"talks": dbtalks});
    }
  }

  Stream<QuerySnapshot> getConferenceTalks(String confID) {
    return firestore
        .collection("conference")
        .doc(confID)
        .collection("talks")
        .snapshots();
  }

  Future getListTalks(String confID) async {
    List<Talk> talks = new List();
    var querytalks = firestore
        .collection("conference")
        .doc(confID)
        .collection("talks")
        .get()
        .then((value) {
      var docs = value.docs;
      print(docs.toString());
      for (int i = 0; i < docs.length; i++) {
        Talk talk = Talk.fromData(docs[i].data());
        print(talk.name);
        talks.add(talk);
        //talks.add(Talk.fromData(doc.data()));
      }
    });
    return talks;
  }

  addTalk(Talk talk, String confID) async {
    await firestore
        .collection("conference")
        .doc(confID)
        .collection('talks')
        .add(talk.toJson())
        .then((docRef) {
      firestore
          .collection("conference")
          .doc(confID)
          .collection('talks')
          .doc(docRef.id)
          .update({"id": docRef.id});
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
