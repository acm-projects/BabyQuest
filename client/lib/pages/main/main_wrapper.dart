import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:client/pages/main/home_page.dart';
import 'package:client/pages/main/profile_page.dart';
import 'package:client/pages/main/shopping_page.dart';
import 'package:client/pages/main/statistics_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
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
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        style: TabStyle.react,
        initialActiveIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          TabItem(icon: Icons.account_circle, title: 'Profile'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.bar_chart, title: 'Statistics'),
          TabItem(icon: Icons.shopping_cart, title: 'Shopping'),
        ],
      ),
    );
  }
}
