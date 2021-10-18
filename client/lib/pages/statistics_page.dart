import 'dart:math' as math;

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      body: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryVariant,
              Colors.white,
            ],
            stops: const [.7, 1],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: '10 October',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondaryVariant,
              thickness: 1,
            ),
            SizedBox(
              height: 130,
              child: PageView.builder(
                itemCount: null,
                controller: pageController,
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DayCircle(
                            fraction: .1,
                            insideText: '${_index * 7 + 1}',
                            topText: 'S',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .2,
                            insideText: '${_index * 7 + 2}',
                            topText: 'M',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .3,
                            insideText: '${_index * 7 + 3}',
                            topText: 'T',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .4,
                            insideText: '${_index * 7 + 4}',
                            topText: 'W',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .5,
                            insideText: '${_index * 7 + 5}',
                            topText: 'T',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .6,
                            insideText: '${_index * 7 + 6}',
                            topText: 'F',
                            onTap: () {},
                          ),
                          const Spacer(),
                          DayCircle(
                            fraction: .7,
                            insideText: '${_index * 7 + 7}',
                            topText: 'S',
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
              color: Theme.of(context).colorScheme.secondaryVariant,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    padding: const EdgeInsets.all(13),
                    child: IncompleteCircle(
                      backgroundColor: Colors.black12,
                      fraction: .25,
                      strokeWidth: 13,
                      circleColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        '25%',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '8h 27m',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const TextSpan(
                          text: '\n',
                        ),
                        TextSpan(
                          text: 'of sleep',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
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
              color: Theme.of(context).colorScheme.secondaryVariant,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      IconStatistics(
                        iconData: Icons.nightlight_round_outlined,
                        text: '1:50 AM',
                        label: 'Slept at',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconStatistics(
                        iconData: Icons.restaurant_outlined,
                        text: '3',
                        label: 'Feedings',
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      IconStatistics(
                        iconData: Icons.wb_sunny_rounded,
                        text: '10:18 AM',
                        label: 'Woke up at',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconStatistics(
                        iconData: Icons.delete,
                        text: '2',
                        label: 'Diaper changes',
                      ),
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondaryVariant,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Add Notes',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DayCircle extends StatelessWidget {
  const DayCircle({
    Key? key,
    this.smallCircleDiameter = 50,
    this.fraction = 0,
    this.insideText = '',
    this.topText = '',
    required this.onTap,
  }) : super(key: key);

  final double smallCircleDiameter;
  final double fraction;
  final String insideText;
  final String topText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            topText,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Ink(
            width: smallCircleDiameter,
            height: smallCircleDiameter,
            padding: const EdgeInsets.all(3),
            child: IncompleteCircle(
              fraction: fraction,
              circleColor: Theme.of(context).colorScheme.primary,
              child: Text(
                insideText,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondaryVariant),
                softWrap: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class IconStatistics extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String label;

  const IconStatistics({
    Key? key,
    required this.iconData,
    this.text = '',
    this.label = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                  child: Icon(iconData,
                      size: 45, color: Theme.of(context).colorScheme.primary),
                  alignment: PlaceholderAlignment.middle),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: label,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class IncompleteCircle extends StatelessWidget {
  final Color circleColor;
  final Color backgroundColor;
  final String text;
  final Widget? child;
  final double strokeWidth;
  final double fraction;

  const IncompleteCircle(
      {Key? key,
      this.circleColor = Colors.red,
      this.text = '',
      this.child,
      this.strokeWidth = 5,
      this.fraction = 1,
      this.backgroundColor = Colors.black12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArcPainter(
          circleColor: circleColor,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
          fraction: fraction),
      child: Center(
        child: child,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final Color circleColor;
  final Color backgroundColor;
  final double strokeWidth;
  final double fraction;

  ArcPainter(
      {Key? key,
      this.circleColor = Colors.red,
      this.backgroundColor = Colors.black12,
      this.strokeWidth = 5,
      this.fraction = 1});

  /*@override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = circleColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final backgroundArc = Path();
    backgroundArc.moveTo(size.width * .5, 0);
    backgroundArc.arcToPoint(
      Offset(size.width * .5, size.height),
      radius: const Radius.circular(1),
    );
    backgroundArc.arcToPoint(
      Offset(size.width * .5, 0),
      radius: const Radius.circular(1),
    );

    final fillArc = Path();

    fillArc.moveTo(size.width * .5, 0);
    fillArc.arcToPoint(
      Offset(
        size.width * (.5 * math.sin(2 * math.pi * fraction) + .5),
        size.height * (.5 * math.sin(2 * math.pi * (fraction - .25)) + .5),
      ),
      radius: Radius.circular(size.width),
    );
    if (fraction > 0.5) {
      fillArc.arcToPoint(
        Offset(size.width * .5, 0),
        radius: const Radius.circular(1),
      );
    }

    canvas.drawPath(backgroundArc, backgroundPaint);
    canvas.drawPath(fillArc, fillPaint);
  }*/

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final startAngle = -math.pi / 2;
    final sweepAngle = (2 * math.pi) * fraction;
    const useCenter = false;
    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 1.5;

    canvas.drawArc(rect, startAngle, 2 * math.pi, useCenter, backgroundPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
