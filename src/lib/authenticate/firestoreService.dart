import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/classes/person.dart';

//TODO change name to Firestore controller para parecer mais mvc

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(Atendee user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future<Atendee> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return Atendee.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
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
