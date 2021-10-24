import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.child,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
        splashColor: backgroundColor == null ||
                backgroundColor == Theme.of(context).colorScheme.secondary
            ? Theme.of(context).colorScheme.primary
            : backgroundColor == Theme.of(context).colorScheme.primary
                ? Theme.of(context).colorScheme.secondary
                : Colors.white,
        child: child ??
            Text(
              text!,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                  color:
                      textColor ?? Theme.of(context).colorScheme.onSecondary),
            ),
      ),
    );
  }
}
