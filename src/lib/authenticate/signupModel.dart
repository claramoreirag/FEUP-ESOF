import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/authenticate/authentication.dart';
import 'package:hello/authenticate/firestoreService.dart';
import 'package:hello/authenticate/locator.dart';

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

    // if (result is bool) {      TODO: push to other page
    //   if (result) {
    //     _navigationService.navigateTo(HomeViewRoute);
    //   } else {
    //     await _dialogService.showDialog(
    //       title: 'Sign Up Failure',
    //       description: 'General sign up failure. Please try again later',
    //     );
    //   }
    // } else {
    //   await _dialogService.showDialog(
    //     title: 'Sign Up Failure',
    //     description: result,
    //   );
    // }
  }
}
