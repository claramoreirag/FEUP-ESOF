import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/authenticate/locator.dart';
import 'firestoreService.dart';
import '../classes/person.dart' as session; //our class user

class Authenticator {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreService _firestoreService = locator<FirestoreService>();

  session.User _currentUser;
  session.User get currentUser => _currentUser;
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();    //FIXME: FIREBASEAUTH IS NOT DEFINED

  //see changes that need to be done in signin
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

/*
  Future<String> register(
      {String displayName,
      String email,
      String password,
      String userRole,
      String location,
      String profilePhoto,
      String phoneNumber,
      String linkedIn,
      String cv}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //((value) => value.user.updateProfile(displayName: displayName));
      await _firestoreService.createUser(session.User(
          id: authResult.user.uid,
          email: email,
          fullName: displayName,
          userRole: userRole,
          location: location,
          profilePhoto: profilePhoto,
          phoneNumber: phoneNumber,
          linkedIn: linkedIn,
          cv: cv));
      return "Registered";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
*/
  Future<String> register(
      {String displayName, String email, String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //((value) => value.user.updateProfile(displayName: displayName));
      await _firestoreService.createUser(session.User(
        id: authResult.user.uid,
        email: email,
        fullName: displayName,
      ));
      return "Registered";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
