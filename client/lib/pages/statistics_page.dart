import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  static const Color accentColor = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        foregroundColor: accentColor,
        backgroundColor: Colors.white,
        title: const Text(
          "Statistics",
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 50),
        ),
      ),
    );
  }
}
