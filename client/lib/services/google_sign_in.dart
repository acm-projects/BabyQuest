import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:client/models/app_user.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // create AppUser object from firebase user
  AppUser? _appUserFromUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get appUser => _auth.authStateChanges().map(_appUserFromUser);

  // sign in with email and password (TO ADD)

  // register with email and password (TO ADD)

  // sign in using google authentication
  Future signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (error) {
      print(error.toString());
    }

    notifyListeners();
  }

  // sign out
  Future signOut() async {
    await googleSignIn.disconnect();
    _auth.signOut();
  }
}
