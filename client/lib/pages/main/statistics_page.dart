import 'package:client/widgets/dotted_divider.dart';
import 'package:client/widgets/fraction_circle.dart';
import 'package:client/widgets/icon_information.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final int _currentDate = 23;
  final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  PageController pageController = PageController(
    viewportFraction: 1,
  );

  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final List<SleepInformation> sleepSessions = [
    const SleepInformation(
      startTime: '1:50 AM',
      endTime: '10:18 PM',
      isFirst: true,
    ),
    const SleepInformation(
      startTime: '3:03 AM',
      endTime: '5:26 PM',
    )
  ];

  @override
  void initState() {
    super.initState();
    //Go to current date on start up
    WidgetsBinding.instance!
        .addPostFrameCallback((timeStamp) => _jumpToIndex(_currentDate));
  }

  void _jumpToIndex(int index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index ~/ 7);
  }

  void _animateToIndex(int index) {
    _selectedIndex.value = index;
    pageController.animateToPage((index ~/ 7),
        duration: const Duration(milliseconds: 1000), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: _selectedIndex,
                        builder: (BuildContext context, value, Widget? child) {
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: days[value % 7],
                                    style:
                                        Theme.of(context).textTheme.headline1),
                                const TextSpan(
                                  text: '  ',
                                ),
                                TextSpan(
                                    text: '${_selectedIndex.value} October',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          _animateToIndex(_currentDate);
                        },
                      ),
                    ],
                  ),
                ),
                const DottedDivider(),
                SizedBox(
                  height: 130,
                  child: PageView.builder(
                    itemCount: null,
                    controller: pageController,
                    onPageChanged: (int index) => _pageIndex.value = index,
                    itemBuilder: (context, index) {
                      return Transform.scale(
                        scale: index == _pageIndex.value ? 1 : .97,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              DayCircle(
                                fraction: ((index * 7 + 0) % 10) / 10,
                                date: '${index * 7 + 0}',
                                day: 'S',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 0;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 1) % 10) / 10,
                                date: '${index * 7 + 1}',
                                day: 'M',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 1;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 2) % 10) / 10,
                                date: '${index * 7 + 2}',
                                day: 'T',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 2;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 3) % 10) / 10,
                                date: '${index * 7 + 3}',
                                day: 'W',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 3;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 4) % 10) / 10,
                                date: '${index * 7 + 4}',
                                day: 'T',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 4;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 5) % 10) / 10,
                                date: '${index * 7 + 5}',
                                day: 'F',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 5;
                                },
                              ),
                              const Spacer(),
                              DayCircle(
                                fraction: ((index * 7 + 6) % 10) / 10,
                                date: '${index * 7 + 6}',
                                day: 'S',
                                onTap: () {
                                  _selectedIndex.value = index * 7 + 6;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const DottedDivider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: MainDayCircle(selectedIndex: _selectedIndex),
                ),
                const DottedDivider(),
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
                const DottedDivider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      IconInformation(
                        iconData: Icons.restaurant_outlined,
                        topText: '3',
                        bottomText: 'Feedings',
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      IconInformation(
                        iconData: Icons.delete,
                        topText: '2',
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
                    splashColor: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Add Notes',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
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
}

class MainDayCircle extends StatelessWidget {
  const MainDayCircle({
    Key? key,
    required ValueNotifier<int> selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final ValueNotifier<int> _selectedIndex;

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
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (BuildContext context, value, Widget? child) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: value % 10),
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                builder: (BuildContext context, double progress, Widget? child) {
                  return FractionCircle(
                    backgroundCircleColor: Colors.black12,
                    fraction: progress / 10,
                    strokeWidth: 13,
                    child: Text(
                      '${(progress * 10).round()}%',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  );
                },
                child: const Icon(Icons.aspect_ratio),
              );
            },
          ),
        ),
        const SizedBox(
          width: 32,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '8h 27m',
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
  const SleepInformation({
    Key? key,
    required this.startTime,
    required this.endTime,
    this.isFirst = false,
  }) : super(key: key);

  final String startTime;
  final String endTime;
  final bool isFirst;

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
