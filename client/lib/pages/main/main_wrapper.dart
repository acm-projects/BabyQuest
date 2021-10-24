import 'package:flutter/material.dart';

import 'package:client/pages/main/home_page.dart';
import 'package:client/pages/main/profile_page.dart';
import 'package:client/pages/main/shopping_page.dart';
import 'package:client/pages/main/statistics_page.dart';
import 'package:client/pages/main/user_input_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  static const Color accentColor = Color(0xFF008080);

  int currentIndex = 1;
  final screens = [
    const ProfilePage(),
    const HomePage(),
    const StatisticsPage(),
    const ShoppingPage(),
    const DataInput()
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
