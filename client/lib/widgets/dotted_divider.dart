import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({Key? key, this.color, this.text}) : super(key: key);

  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      '-' * 200,
      maxLines: 1,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: color ?? Theme.of(context).colorScheme.onBackground,
        letterSpacing: 2,
      ),
    );
  }
}
