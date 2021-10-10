import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/provider/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
          actions: [
          TextButton(
            child: const Text(
              'logout',
              style: TextStyle(color: Colors.white),
              ),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          )
        ],
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                    alignment: Alignment.center,
                    child: Image.network(
                      'https://www.muralswallpaper.co.uk/app/uploads/baby-clouds-and-moon-nursery-room-825x535.jpg',
                      height: 251,
                      width: double.infinity,
                      fit: BoxFit.cover,


                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 60),
                      alignment: Alignment.center,
                      child: const Text(
                        '"Quote of the day" \n -Author name',
                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 22.0),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {

                },

                child: const Text(
                  "Record Sleep",
                  style: TextStyle(color: Colors.white),
                ),
                style:ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {

                },
                child: const Text(
                  "Record Feeding",
                  style: TextStyle(color: Colors.white),
                ),
                style:ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {

                },
                child: const Text(
                  "Record Sleep",
                  style: TextStyle(color: Colors.white),
                ),
                style:ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.green),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green)),
              ),

            )
          ],
        )
    ),);
  }
}
