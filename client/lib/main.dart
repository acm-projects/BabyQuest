import 'package:client/pages/home_page.dart';
import 'package:client/pages/shopping_page.dart';
import 'package:client/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/profile_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white),
  );
  runApp(const MyApp());
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
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
  static const Color accentColor = Color(0xFF008080);

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
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.white,
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
