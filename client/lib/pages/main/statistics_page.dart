import 'package:client/widgets/fraction_circle.dart';
import 'package:client/widgets/icon_information.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _index = 0;
  PageController pageController = PageController(viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
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
                    padding: const EdgeInsets.only(top: 48),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sunday',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            const TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: '10 October',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 130,
                    child: PageView.builder(
                      itemCount: null,
                      controller: pageController,
                      onPageChanged: (int index) =>
                          setState(() => _index = index),
                      itemBuilder: (context, index) {
                        return Transform.scale(
                          scale: index == _index ? 1 : .97,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                DayCircle(
                                  fraction: ((index * 7 + 1) % 10) / 10,
                                  date: '${index * 7 + 1}',
                                  day: 'S',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 2) % 10) / 10,
                                  date: '${index * 7 + 2}',
                                  day: 'M',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 3) % 10) / 10,
                                  date: '${index * 7 + 3}',
                                  day: 'T',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 4) % 10) / 10,
                                  date: '${index * 7 + 4}',
                                  day: 'W',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 5) % 10) / 10,
                                  date: '${index * 7 + 5}',
                                  day: 'T',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 6) % 10) / 10,
                                  date: '${index * 7 + 6}',
                                  day: 'F',
                                  onTap: () {},
                                ),
                                const Spacer(),
                                DayCircle(
                                  fraction: ((index * 7 + 7) % 10) / 10,
                                  date: '${index * 7 + 7}',
                                  day: 'S',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(16),
                          child: FractionCircle(
                            backgroundCircleColor: Colors.black12,
                            fraction: .25,
                            strokeWidth: 13,
                            child: Text(
                              '25%',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              const TextSpan(
                                text: '\n',
                              ),
                              TextSpan(
                                text: 'of sleep',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            IconInformation(
                              iconData: Icons.nightlight_round_outlined,
                              topText: '1:50 AM',
                              bottomText: 'Slept at',
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            IconInformation(
                              iconData: Icons.restaurant_outlined,
                              topText: '3',
                              bottomText: 'Feedings',
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            IconInformation(
                              iconData: Icons.wb_sunny_rounded,
                              topText: '10:18 AM',
                              bottomText: 'Woke up at',
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
                        const Spacer()
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Add Notes',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
        InkWell(
          onTap: onTap,
          child: Ink(
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
      ],
    );
  }
}
