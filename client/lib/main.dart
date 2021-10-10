import 'package:client/page/home_page.dart';
import 'package:client/provider/google_sign_in.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white),
  );

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