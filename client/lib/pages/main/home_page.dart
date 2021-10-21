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

  int buttonCase = 3;

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
        color: Colors.grey,
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: SizedBox(
                height: 80, //height of button
                width: 200, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //background color of button
                      side: const BorderSide(
                          width: 3,
                          color: Colors.green), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(
                          20) //content padding inside button

                      ),
                  onPressed: () {
                    //code to execute when this button is pressed.
                    buttonCase = 0;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: const Text("Record Sleep"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: SizedBox(
                height: 80, //height of button
                width: 200, //width of button
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, //background color of button
                        side: const BorderSide(
                            width: 3,
                            color: Colors.green), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(
                            20) //content padding inside button

                        ),
                    onPressed: () {
                      buttonCase = 1;
                      //code to execute when this button is pressed.
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    },
                    child: const Text("Record Feedings")),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              child: SizedBox(
                height: 80, //height of button
                width: 200, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, //background color of button
                      side: const BorderSide(
                          width: 3,
                          color: Colors.green), //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.all(
                          20) //content padding inside button

                      ),
                  onPressed: () {
                    buttonCase = 2;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: const Text("Record Diaper Changes"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    int _feedingCounter = 0;
    if (buttonCase == 0) {
      return AlertDialog(
        title: const Text('Record Sleep'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Current Number of sleep: '),
            Text('$_feedingCounter'),
            ElevatedButton(
              onPressed: () {
                _feedingCounter++;
              },
              child: const Text('Add sleep'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            //textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    if (buttonCase == 1) {
      return AlertDialog(
        title: const Text('Record Feedings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Current Number of feedings: '),
            Text('$_feedingCounter'),
            ElevatedButton(
              onPressed: () {
                _feedingCounter++;
              },
              child: const Text('Add feedings'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            //textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Record Diaper Changes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Current Number of diaper changes: '),
            Text('$_feedingCounter'),
            ElevatedButton(
              onPressed: () {
                _feedingCounter++;
              },
              child: const Text('Add diaper changes'),
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            //textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
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
