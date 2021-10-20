import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:client/pages/wrapper.dart';
import 'package:client/services/google_sign_in.dart';

Future main() async {
  // setup flutter and firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      //systemNavigationBarColor: Colors.white
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          //fontFamily: 'Sonorous',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green,
            primaryVariant: const Color(0xFFE9FAE9),
            secondary: Colors.grey.shade600,
            secondaryVariant: Colors.grey.shade500,
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w800,
                fontSize: 20),
            subtitle1: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w300,
                fontSize: 15),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
