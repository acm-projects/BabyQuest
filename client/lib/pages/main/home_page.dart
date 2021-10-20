import 'package:flutter/material.dart';

import 'package:client/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qodMessage = '';
  String qodAuthor = '';
  String qodImage =
      'https://www.muralswallpaper.co.uk/app/uploads/baby-clouds-and-moon-nursery-room-825x535.jpg';

  @override
  void initState() {
    _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String quoteOfTheDay = '"' + qodMessage + '" \n -' + qodAuthor;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Welcome <Baby Name>!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
              ),
            ),
            backgroundColor: Colors.green,
          ),
          body: Column(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 60),
                      alignment: Alignment.center,
                      child: Image.network(
                        qodImage,
                        height: 251,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 60),
                        alignment: Alignment.center,
                        child: Text(
                          quoteOfTheDay,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        )),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Record Sleep",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Record Feeding",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Record Sleep",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.green),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                ),
              )
            ],
          )),
    );
  }

  Future _setup() async {
    List<String> qodData = await DataService.getQOD();

    setState(() {
      qodMessage = qodData[1];
      qodAuthor = qodData[2];
      qodImage = qodData[3];
    });
  }
}
