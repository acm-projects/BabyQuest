import 'package:flutter/material.dart';

class OldProfilePage extends StatefulWidget {
  const OldProfilePage({Key? key}) : super(key: key);

  @override
  _OldProfilePageState createState() => _OldProfilePageState();
}

class _OldProfilePageState extends State<OldProfilePage> {
  /*static const Color appBarColor = Color(0xB3ffffff);
  static const Color darkGreyColor = Color(0xFF455A64);
  static const Color buttonBackgroundColor = Color(0xE69FD6E2);
  static const Color primaryColor = Color(0xFFFAF0DC);*/
  static const Color accentColor = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Nursery1.jpg'),
          fit: BoxFit.cover,
          //colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        //backgroundColor: Colors.black.withOpacity(0.6),
        backgroundColor: const Color(0xFFDCF0E7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          foregroundColor: accentColor,
          backgroundColor: Colors.white,
          title: const Text(
            "Osbaldo Waldo",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 50),
          ),
        ),
        body: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  //To Do
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  softWrap: true,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 0),
              clipBehavior: Clip.antiAlias,
              child: const CircleAvatar(
                radius: 130,
                backgroundImage: AssetImage('images/Osbaldo.jpg'),
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                //border: Border.all(color: darkGreyColor, width: 4),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: const Text(
                '1 Year Old \n'
                '2\'5" Tall \n'
                '20 pounds \n'
                'Allergies: \n'
                'Latex \n'
                'Strawberries \n'
                'Eggs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //To Do
                      },
                      icon: const Icon(Icons.phone),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              //side: BorderSide(color: Colors.redAccent),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      label: const Text('Emergency \n'
                          'Contact'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () {
                          //To Do
                        },
                        icon: const Icon(Icons.share),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                //side: BorderSide(color: Colors.lightBlueAccent),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlueAccent)),
                        label: const Text('Share Info')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
