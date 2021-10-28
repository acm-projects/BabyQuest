import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashPage extends StatefulWidget {
  final bool timed;
  final int milliseconds;
  final String label;
  final Function? completed;

  const SplashPage(this.label,
      {this.timed = true, this.milliseconds = 3500, this.completed, Key? key})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 50.0,
                    child: FaIcon(
                      FontAwesomeIcons.babyCarriage,
                      color: Theme.of(context).colorScheme.primary,
                      size: 100.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  SpinKitWave(itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }

  _navigateToHome() async {
    if (!widget.timed) return;

    await Future.delayed(Duration(milliseconds: widget.milliseconds), () {
      if (widget.completed != null) {
        widget.completed!();
      }
    });
  }
}
