import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconInformation extends StatefulWidget {
  final IconData? iconData;
  final String? topText;
  final String? bottomText;
  final VoidCallback? onTap;
  final bool enabled;

  const IconInformation({
    Key? key,
    this.iconData,
    this.topText = '',
    this.bottomText = '',
    this.onTap,
    this.enabled = false,
  }) : super(key: key);

  @override
  State<IconInformation> createState() => _IconInformationState();
}

class _IconInformationState extends State<IconInformation> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.primary,
      onTap: widget.enabled ? widget.onTap : null,
      child: Row(
        children: [
          if (widget.iconData != null)
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                      child: Icon(
                        widget.iconData,
                        size: 45,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      alignment: PlaceholderAlignment.middle),
                ],
              ),
            ),
          if (widget.iconData != null)
            const SizedBox(
              width: 8,
            ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.topText,
                    style: Theme.of(context).textTheme.headline2),
                const TextSpan(text: '\n'),
                TextSpan(
                    text: widget.bottomText,
                    style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
