import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
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
          "Shopping",
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 50),
        ),
      ),
    );
  }
}