import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/widgets/sign_up_widget.dart';
import 'package:client/widgets/logged_in_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return LoggedInWidget(); //home page goes here!
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}