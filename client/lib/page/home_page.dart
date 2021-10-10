import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/widgets/sign_up_widget.dart';
import 'package:client/page/main_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const MainPage(); //home page goes here!
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else {
            return SignUpWidget();
          }
        },
      ),
    );
  }
}