import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/widgets/sign_up_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpWidget(),/*StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(child: Text('Logged in test'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return SignUpWidget();
          }

        }
      ),*/
    );
  }
}