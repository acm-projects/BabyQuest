import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor2/tinycolor2.dart';

import 'package:client/pages/splash_page.dart';
import 'package:client/pages/wrapper.dart';
import 'package:client/services/auth_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple.shade300,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: const TextTheme(
            headline1: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            headline2: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            headline3: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            subtitle1: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
          ),
          canvasColor: Colors.green.shade200,
          scaffoldBackgroundColor: const Color(0xFFFFF2CC),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: createMaterialColor(Colors.deepPurple.shade300),
          ).copyWith(
            onPrimary: Colors.white,
            background:  const Color(0xFFFFF2CC),
            onBackground: Colors.grey.shade700,
            onSurface: Colors.grey.shade700,
            secondary: Colors.green.shade200,
            onSecondary: Colors.green.shade200.darken(40).desaturate(25),
          ),
          snackBarTheme: SnackBarThemeData(
            elevation: 0,
            backgroundColor: Colors.green.shade200,
            contentTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.green.shade200.darken(40).desaturate(25),
            ),
            actionTextColor: Colors.grey.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(style: BorderStyle.none),
              primary: Colors.grey.shade700,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              backgroundColor: Colors.green.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                primary: Colors.green.shade200,
                onPrimary: Colors.grey.shade700),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            errorStyle: TextStyle(height: 0),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: isLoaded
            ? const Wrapper()
            : SplashPage("Waking Up From A Nap...",
                completed: _completeLoading),
      ),
    );
  }

  void _completeLoading() {
    setState(() => isLoaded = true);
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
