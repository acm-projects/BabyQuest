import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:client/page/home_page.dart';
import 'package:client/provider/google_sign_in.dart';
import 'package:provider/provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
      );
  }
}