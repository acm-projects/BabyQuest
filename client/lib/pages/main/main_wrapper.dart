import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:client/models/app_user.dart';
import 'package:client/pages/main/home_page.dart';
import 'package:client/pages/main/profile_page.dart';
import 'package:client/pages/main/shopping_page.dart';
import 'package:client/pages/main/statistics_page.dart';
import 'package:client/pages/main/create_profile_page.dart';

class MainWrapper extends StatefulWidget {
  final Function refresh;

  const MainWrapper(this.refresh, {Key? key}) : super(key: key);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  bool creatingProfile = false;
  PageController pageController = PageController(initialPage: 1);

  _MainWrapperState() {
    if (AppUser.currentUser != null &&
        AppUser.currentUser!.ownedProfiles.isEmpty) {
      creatingProfile = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (creatingProfile) {
      return CreateProfilePage(_creatingNewProfile);
    } else {
      return _mainPage();
    }
  }

  Widget _mainPage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ProfilePage(_creatingNewProfile, widget.refresh),
          const HomePage(),
          const StatisticsPage(),
          const ShoppingPage(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 1,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.account_circle, title: 'Profile'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.bar_chart, title: 'Statistics'),
          TabItem(icon: Icons.shopping_cart, title: 'Shopping'),
        ],
        onTap: (index) => pageController.jumpToPage(index),
      ),
    );
  }

  void _creatingNewProfile({bool finished = true}) {
    setState(() => creatingProfile = !finished);
  }
}
