import 'package:client/pages/home_page.dart';
import 'package:client/pages/profile_page.dart';
import 'package:client/pages/shopping_page.dart';
import 'package:client/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      //systemNavigationBarColor: Colors.white
    ),
  );
  runApp(const MyApp());
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Parent',
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
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 1;
  final screens = [
    const ProfilePage(),
    const HomePage(),
    const StatisticsPage(),
    const ShoppingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Statistics"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Shopping")
        ],
      ),
    );
  }
}
