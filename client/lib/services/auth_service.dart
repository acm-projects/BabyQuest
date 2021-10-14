import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:client/models/app_user.dart';

class AuthService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  // create AppUser object from firebase user
  AppUser? _appUserFromUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get appUser =>
      _auth.authStateChanges().map(_appUserFromUser);

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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // sign in using google authentication
  Future signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
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
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }

    _auth.signOut();
  }
}
