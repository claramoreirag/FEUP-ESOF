import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/controller/locator.dart';
import 'firestoreService.dart';
import '../model/person.dart';

class Authenticator {
  final FirebaseAuth _auth;

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Authenticator(this._auth);

  FirestoreService _firestoreService = locator<FirestoreService>();

  Atendee _currentUser;
  Atendee get currentUser => _currentUser;

  //see changes that need to be done in signin
  Future<String> signIn({String email, String password}) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _populateCurrentUser(authResult.user);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> register(
      {String displayName,
      String email,
      String password,
      String userRole,
      String location,
      String phoneNumber}) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestoreService.createUser(Atendee(
        id: authResult.user.uid,
        email: email,
        fullName: displayName,
        userRole: userRole,
        location: location,
        phoneNumber: phoneNumber,
      ));
      await _populateCurrentUser(authResult.user);
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
