import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:client/models/app_user.dart';
import 'package:client/models/baby_profile.dart';

class AuthService extends ChangeNotifier {
  static final _auth = FirebaseAuth.instance;
  static final _googleSignIn = GoogleSignIn();

  // auth change user stream
  static Stream<AppUser?> get appUserStream =>
      _auth.authStateChanges().map(_appUserFromUser);

  // create AppUser object from firebase user
  static AppUser? _appUserFromUser(User? user) {
    AppUser.currentUser = user != null ? AppUser(user.uid, user.email!) : null;

    if (AppUser.currentUser == null) {
      BabyProfile.currentProfile = null;
    }

    return AppUser.currentUser;
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password,
      {Function? setError}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        if (error != null) {
          switch (error.code) {
            case 'invalid-email':
              setError!('Invalid email address.');
              break;
            case 'user-not-found':
              setError!('That account doesn\'t exist.');
              break;
            case 'wrong-password':
              setError!('Your password is incorrect.');
              break;
            default:
              setError!('Something went wrong! Please try again.');
          }
        }
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // sign in using google authentication
  Future signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (error) {
      debugPrint(error.toString());
    }

    notifyListeners();
  }

  // sign out
  Future signOut() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    _auth.signOut();
  }
}
