import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:client/page/home_page.dart';
import 'package:client/provider/google_sign_in.dart';
import 'package:provider/provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (Firebase.apps.isEmpty) {
    print('no apps running...');
  } else {
    print('app is running...');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) =>  GoogleSignInProvider(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
      ),
  );
}