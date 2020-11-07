import 'package:firebase_core/firebase_core.dart';  
import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
	final FirebaseAuth _auth;



  Stream<User> get authStateChanges => _auth.authStateChanges();

  Authenticator(this._auth);

  Future<String> signIn({String email, String password}) async {
  	try {
    		await _auth.signInWithEmailAndPassword(email: email, password: password);
			return "Signed In";
  	} on FirebaseAuthException catch (e) {
    		return e.message;
  	}
	}

	Future<String> register({String displayName, String email, String password}) async {
    try {
    		await _auth.createUserWithEmailAndPassword(
        	email: email,
      		password: password
    		).then((value) => value.user.updateProfile(displayName: displayName));
    		return "Registered";
  	} on FirebaseAuthException catch (e) {
      	return e.message;
  	}
	}

	Future<void> signOut() async {
	await _auth.signOut();
  }
}