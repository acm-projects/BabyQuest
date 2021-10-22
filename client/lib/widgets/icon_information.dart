import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconInformation extends StatelessWidget {
  final IconData iconData;
  final String topText;
  final String bottomText;

  const IconInformation({
    Key? key,
    required this.iconData,
    this.topText = '',
    this.bottomText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                  child: Icon(
                    iconData,
                    size: 45,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                  text: topText, style: Theme.of(context).textTheme.headline2),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: bottomText,
                  style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
      ],
    );
  }
}
