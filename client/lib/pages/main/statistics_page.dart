import 'package:flutter/material.dart';

import 'package:client/models/baby_profile.dart';
import 'package:client/models/day_stats.dart';
import 'package:client/widgets/dotted_divider.dart';
import 'package:client/widgets/fraction_circle.dart';
import 'package:client/widgets/icon_information.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  BabyProfile currentBby = BabyProfile.currentProfile;

  //Date the user registers for the app
  late DateTime _startDate;
  late final int _currentDateIndex;
  late final int _endDateIndex;
  DateTime _currentDate = DateTime.now();

  int _feedingCount = 0;
  int _diaperCount = 0;
  int _sleepMins = 0;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<SleepInformation> sleepSessions = [];

  late int _pageIndex;
  late int _selectedIndex;
  late PageController pageController;

  String _getFormattedTime(DateTime time) {
    int hour = (time.hour % 12 == 0) ? 12 : time.hour % 12;
    String minute = time.minute.toString().padLeft(2, '0');
    bool am = time.hour < 12;
    return '$hour:$minute ${am ? 'AM' : 'PM'}';
  }

  int _getDaySleepMins(int dayIndex) {
    DateTime _date = _startDate.add(Duration(days: dayIndex));
    DayStats stats = currentBby.getDayStats(_date);

    int sleepMins = 0;

    stats.sleep.forEach((startTime, endTime) {
      sleepMins += endTime.difference(startTime).inMinutes;
    });

    return sleepMins;
  }

  void _setSelectedDateTime() {
    _currentDate = _startDate.add(Duration(days: _selectedIndex));
    DayStats stats = currentBby.getDayStats(_currentDate);

    _feedingCount = stats.feedings.length;
    _diaperCount = stats.diaperChanges.length;
    _sleepMins = 0;
    sleepSessions = [];

    stats.sleep.forEach((startTime, endTime) {
      _sleepMins += endTime.difference(startTime).inMinutes;

      sleepSessions.add(
        SleepInformation(
          startDate: startTime,
          startTime: _getFormattedTime(startTime),
          endTime: _getFormattedTime(endTime),
        ),
      );
    });

    sleepSessions.sort((left, right) {
      return left.startDate.millisecondsSinceEpoch.compareTo(right.startDate.millisecondsSinceEpoch);
    });

    if (sleepSessions.isNotEmpty) {
      sleepSessions.first.isFirst = true;
    }

    setState(() {});
  }

  int _getDateIndex(DateTime date) {
    return date.difference(_startDate).inDays;
  }

  void _jumpToIndex(int index) {
    _selectedIndex = index;
    _setSelectedDateTime();
    pageController.jumpToPage(index ~/ 7);
  }

  void _animateToIndex(int index) {
    _selectedIndex = index;
    _setSelectedDateTime();
    pageController.animateToPage((index ~/ 7),
        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
  }

  _StatisticsPageState() {
    //Always Starts On A Sunday
    final registrationDate = currentBby.created;
    final now = DateTime.now();
    _startDate = DateTime(registrationDate.year, registrationDate.month,
        registrationDate.day - registrationDate.weekday % 7);
    _currentDateIndex = now.difference(_startDate).inDays;
    _endDateIndex = _currentDateIndex + 7 - now.weekday;

    _pageIndex = _currentDateIndex ~/ 7;
    _selectedIndex = _currentDateIndex;
    pageController = PageController(
      viewportFraction: 1,
      initialPage: (_pageIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setSelectedDateTime();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Color(0x15FFFFFF), BlendMode.dstATop),
                image: AssetImage('assets/images/undraw_play.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: days[_currentDate.weekday - 1],
                                style: Theme.of(context).textTheme.headline1),
                            const TextSpan(
                              text: '  ',
                            ),
                            TextSpan(
                                text: '${_currentDate.day}',
                                style: Theme.of(context).textTheme.headline2),
                            const TextSpan(
                              text: '  ',
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: months[_currentDate.month - 1],
                                  style: Theme.of(context).textTheme.headline3),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                  text: '${_currentDate.year}',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () async {
                          DateTime targetDate = await _selectDate(context);
                          int index = _getDateIndex(targetDate);
                          _animateToIndex(index);
                        },
                      ),
                    ],
                  ),
                ),
                const DottedDivider(),
                SizedBox(
                  height: 130,
                  child: PageView.builder(
                    itemCount: _endDateIndex ~/ 7,
                    controller: pageController,
                    onPageChanged: (int index) => _pageIndex = index,
                    itemBuilder: (context, index) {
                      return Transform.scale(
                        scale: index == _pageIndex ? 1 : 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(7, (int listIndex) {
                                return DayCircle(
                                  fraction:
                                      _getDaySleepMins(index * 7 + listIndex) /
                                          1020,
                                  date:
                                      '${_startDate.add(Duration(days: index * 7 + listIndex)).day}',
                                  day: days[_startDate
                                              .add(Duration(
                                                  days: index * 7 + listIndex))
                                              .weekday -
                                          1]
                                      .substring(0, 1),
                                  onTap: () {
                                    _jumpToIndex(index * 7 + listIndex);
                                  },
                                );
                              })),
                        ),
                      );
                    },
                  ),
                ),
                const DottedDivider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: MainDayCircle(
                    selectedIndex: _selectedIndex,
                    sleepMins: _sleepMins,
                  ),
                ),
                const DottedDivider(),
                if (sleepSessions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemExtent: 64,
                      itemCount: sleepSessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return sleepSessions[index];
                      },
                    ),
                  ),
                if (sleepSessions.isNotEmpty) const DottedDivider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconInformation(
                        iconData: Icons.restaurant_outlined,
                        topText: '$_feedingCount',
                        bottomText: 'Feedings',
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      IconInformation(
                        iconData: Icons.delete,
                        topText: '$_diaperCount',
                        bottomText: 'Diaper changes',
                      ),
                    ],
                  ),
                ),
                const DottedDivider(),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 48),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Add Notes',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: _currentDate, // Refer step 1
      firstDate: _startDate,
      lastDate: _startDate.add(Duration(days: _endDateIndex - 1)),
    );
  }
}

class MainDayCircle extends StatelessWidget {
  const MainDayCircle({
    Key? key,
    required this.selectedIndex,
    required this.sleepMins,
  }) : super(key: key);

  final int selectedIndex;
  final int sleepMins;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(16),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: sleepMins / 960), // 16 hours
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            builder: (BuildContext context, double progress, Widget? child) {
              return FractionCircle(
                backgroundCircleColor: Colors.black12,
                fraction: progress.clamp(0, 1),
                strokeWidth: 13,
                child: Text(
                  '${(progress * 100).round().clamp(0, 100)}%',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              );
            },
            child: const Icon(Icons.aspect_ratio),
          ),
        ),
        const SizedBox(
          width: 32,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${sleepMins ~/ 60}h ${sleepMins % 60}m',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              const TextSpan(
                text: '\n',
              ),
              TextSpan(
                text: 'of sleep',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              )
            ],
          ),
        )
      ],
    );
  }
}

class SleepInformation extends StatelessWidget {
  final DateTime startDate;
  final String startTime;
  final String endTime;
  bool isFirst;

  SleepInformation({
    Key? key,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (isFirst)
            ? RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                          Icons.nightlight_round_outlined,
                          size: 45,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        alignment: PlaceholderAlignment.middle),
                  ],
                ),
              )
            : const SizedBox(
                width: 45,
              ),
        const SizedBox(
          width: 8,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: startTime,
                  style: Theme.of(context).textTheme.headline2),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: 'Slept at',
                  style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                '∙' * 100,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
              ),
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: endTime, style: Theme.of(context).textTheme.headline2),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: 'Woke up at',
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        (isFirst)
            ? RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                          Icons.wb_sunny_rounded,
                          size: 45,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        alignment: PlaceholderAlignment.middle),
                  ],
                ),
              )
            : const SizedBox(
                width: 45,
              ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}

class DayCircle extends StatelessWidget {
  const DayCircle({
    Key? key,
    this.smallCircleDiameter = 50,
    this.fraction = 0,
    this.date = '',
    this.day = '',
    required this.onTap,
  }) : super(key: key);

  final double smallCircleDiameter;
  final double fraction;
  final String date;
  final String day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            day,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.primary,
              onTap: onTap,
              child: Ink(
                decoration: const ShapeDecoration(shape: CircleBorder()),
                width: smallCircleDiameter,
                height: smallCircleDiameter,
                padding: const EdgeInsets.all(3),
                child: FractionCircle(
                  fraction: fraction,
                  primaryCircleColor: Theme.of(context).colorScheme.primary,
                  backgroundCircleColor: Colors.black12,
                  child: Text(
                    date,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onBackground),
                    softWrap: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
