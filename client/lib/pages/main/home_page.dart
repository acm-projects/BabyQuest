import 'package:client/widgets/round_button.dart';
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

  bool sleeping = false;

  @override
  void initState() {
    _setup();
    super.initState();
  }

  SnackBar getSnackBar(String text, VoidCallback onPressed) {
    return SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1250),
      content: Text(text),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: onPressed,
      ),
    );
  }

  void _showSleepStatus() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1250),
        content: Text(sleeping ? 'Starting Sleep!' : 'Sleep Recorded!'),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      ),
    );
  }

  void _recordFeeding() {
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(
        'Feeding Recorded!',
        () {},
      ),
    );
  }

  void _recordDiaper() {
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(
        'Diaper Change Recorded!',
        () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Color(0x25FFFFFF), BlendMode.dstATop),
                image: AssetImage('assets/images/undraw_baby.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 16),
                  child: Text(
                    'Welcome Back Oscar!',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onBackground,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        qodMessage,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '- ' + qodAuthor,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onBackground,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, bottom: 48, top: 16),
                  child: Column(
                    children: [
                      RoundButton(
                        backgroundColor: sleeping
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        textColor: sleeping
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSecondary,
                        text: sleeping ? 'Stop Sleep' : 'Start Sleep',
                        onPressed: () {
                          setState(() {
                            sleeping = !sleeping;
                          });
                          _showSleepStatus();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RoundButton(
                        text: 'Record Feeding',
                        onPressed: _recordFeeding,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RoundButton(
                        text: 'Record Diaper Change',
                        onPressed: _recordDiaper,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
