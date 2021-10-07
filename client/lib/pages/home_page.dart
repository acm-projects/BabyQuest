import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Temoc"),
      ),
      body: Column(
        children: const [
          Expanded(
            child: Image(
              image: AssetImage('images/Temoc.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
