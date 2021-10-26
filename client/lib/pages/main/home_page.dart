import 'package:client/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:client/services/data_service.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _qodMessage = '';
  String _qodAuthor = '';
  String _qodImage =
      'https://www.muralswallpaper.co.uk/app/uploads/baby-clouds-and-moon-nursery-room-825x535.jpg';

  bool _isSleeping = false;
  int _feedingCount = 0;
  int _diaperCount = 0;

  int _sleepDays = 0;
  int _sleepHours = 0;
  int _sleepMins = 0;

  @override
  void initState() {
    _setup();
    super.initState();
  }

  SnackBar getSnackBar(String text, [VoidCallback? onPressed]) {
    return SnackBar(
      padding: (onPressed != null)
          ? const EdgeInsets.symmetric(horizontal: 16)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1250),
      content: Text(text),
      action: (onPressed != null)
          ? SnackBarAction(
              label: 'Undo',
              onPressed: onPressed,
            )
          : null,
    );
  }

  void _showSleepStatus() {
    String sleepMessage = '';
    int unitCount = 0;

    //Builds the message. Only shows 2 units of time (Days, Minutes, Seconds)
    if (_sleepDays > 0) {
      if (_sleepDays == 1) {
        sleepMessage += '1 day';
        unitCount++;
      } else {
        sleepMessage += '$_sleepDays days';
        unitCount++;
      }
    }
    if (_sleepHours > 0) {
      if (sleepMessage.isNotEmpty) {
        sleepMessage += ' and ';
      }
      if (_sleepHours == 1) {
        sleepMessage += '1 hr';
        unitCount++;
      } else {
        sleepMessage += '$_sleepHours hrs';
        unitCount++;
      }
    }
    if (_sleepMins > 0 && unitCount < 2) {
      if (sleepMessage.isNotEmpty) {
        sleepMessage += ' and ';
      }
      if (_sleepMins == 1) {
        sleepMessage += '1 min';
        unitCount++;
      } else {
        sleepMessage += '$_sleepMins mins';
        unitCount++;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1250),
        content: Text(_isSleeping
            ? 'Starting Sleep...'
            : _sleepDays < 1
                ? '${_sleepHours}hrs and ${_sleepMins}mins of Sleep Recorded'
                : '$_sleepDays days and ${_sleepHours}hrs of Sleep Recorded'),
      ),
    );
  }

  void _recordFeeding() {
    _feedingCount++;
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(
        _feedingCount > 1
            ? '$_feedingCount Feedings Recorded'
            : '$_feedingCount Feeding Recorded',
        () => _feedingCount--,
      ),
    );
  }

  void _recordDiaper() {
    _diaperCount++;
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(
        _diaperCount > 1
            ? '$_diaperCount Diaper Changes Recorded'
            : '$_diaperCount Diaper Change Recorded',
        () => _diaperCount--,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                child: InkWell(
                  splashColor: Theme.of(context).colorScheme.primary,
                  onTap: () {},
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: '$_qodMessage - $_qodAuthor'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      getSnackBar(
                        'Quote Copied To Clipboard',
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        _qodMessage,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '- ' + _qodAuthor,
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
              ),
              Divider(
                color: Theme.of(context).colorScheme.onBackground,
                thickness: 1,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, bottom: 48, top: 16),
                child: Column(
                  children: [
                    RoundButton(
                      backgroundColor: _isSleeping
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      textColor: _isSleeping
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondary,
                      text: _isSleeping ? 'Stop Sleep' : 'Start Sleep',
                      onPressed: () {
                        Future.delayed(
                            ButtonTheme.of(context)
                                .getAnimationDuration(MaterialButton(
                              onPressed: () {},
                            )), () {
                          setState(() {
                            _isSleeping = !_isSleeping;
                            //To Do
                            _sleepHours = 7;
                            _sleepMins = 36;
                          });
                          _showSleepStatus();
                        });
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
    );
  }

  Future _setup() async {
    List<String> qodData = await DataService.getQOD();

    setState(() {
      _qodMessage = qodData[1];
      _qodAuthor = qodData[2];
      _qodImage = qodData[3];
    });
  }
}
