import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/authenticate/locator.dart';
import 'firestoreService.dart';
import '../classes/person.dart';

class Authenticator {
  final FirebaseAuth _auth;

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Authenticator(this._auth);

  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreService _firestoreService = locator<FirestoreService>();

  Atendee _currentUser;
  Atendee get currentUser => _currentUser;
  // Stream<User> get authStateChanges =>
  // _firebaseAuth.authStateChanges(); //FIXME: FIREBASEAUTH IS NOT DEFINED

  //FIXME: FIREBASEAUTH IS NOT DEFINED

  //see changes that need to be done in signin
  Future<String> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
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
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //((value) => value.user.updateProfile(displayName: displayName));
      await _firestoreService.createUser(Atendee(
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
    await _auth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    var user = _auth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
