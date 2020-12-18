import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/controller/authentication.dart';

class SignUpViewModel {
  final Authenticator _auth = Authenticator(FirebaseAuth.instance);

  Future signUp({
    @required String displayName,
    @required String email,
    @required String password,
    String location,
    String phoneNumber,
    String userRole,
  }) async {
    var result = await _auth.register(
      displayName: displayName,
      email: email,
      password: password,
      location: location,
      phoneNumber: phoneNumber,
      userRole: userRole,
    );

    return result;
  }
}
