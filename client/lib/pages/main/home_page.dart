import 'package:client/widgets/dotted_divider.dart';
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

  SnackBar _getSnackBar({required String text, VoidCallback? onPressed}) {
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

  //Builds the message. Only shows 2 units of time (Days, Minutes, Seconds)
  String _getSleepMessage() {
    String sleepMessage = '';
    int unitCount = 0;

    if (_sleepDays > 0) {
      if (_sleepDays == 1) {
        sleepMessage += '1 Day';
        unitCount++;
      } else {
        sleepMessage += '$_sleepDays Days';
        unitCount++;
      }
    }
    if (_sleepHours > 0) {
      if (sleepMessage.isNotEmpty) {
        sleepMessage += ' and ';
      }
      if (_sleepHours == 1) {
        sleepMessage += '1 Hr';
        unitCount++;
      } else {
        sleepMessage += '$_sleepHours Hrs';
        unitCount++;
      }
    }
    if (_sleepMins > 0 && unitCount < 2) {
      if (sleepMessage.isNotEmpty) {
        sleepMessage += ' and ';
      }
      if (_sleepMins == 1) {
        sleepMessage += '1 Min';
        unitCount++;
      } else {
        sleepMessage += '$_sleepMins Mins';
        unitCount++;
      }
    }
    sleepMessage += ' of Sleep';
    return 'Recorded ' + sleepMessage;
  }

  void _showSleepStatus() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1250),
        content: Text(_isSleeping ? 'Starting Sleep...' : _getSleepMessage()),
      ),
    );
  }

  void _recordFeeding() {
    setState(() => _feedingCount++);
    ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(
        text: _feedingCount > 1
            ? '$_feedingCount Feedings Recorded'
            : '$_feedingCount Feeding Recorded',
        onPressed: () => setState(() => _feedingCount--),
      ),
    );
  }

  void _recordDiaper() {
    setState(() => _diaperCount++);
    ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(
        text: _diaperCount > 1
            ? '$_diaperCount Diaper Changes Recorded'
            : '$_diaperCount Diaper Change Recorded',
        onPressed: () => setState(() => _diaperCount--),
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
              const DottedDivider(),
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
                      _getSnackBar(
                        text: 'Quote Copied To Clipboard',
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
              const DottedDivider(),
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
                      text: 'Record Feeding  |  $_feedingCount',
                      onPressed: _recordFeeding,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RoundButton(
                      text: 'Record Diaper Change  |  $_diaperCount',
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
    });
  }
}
