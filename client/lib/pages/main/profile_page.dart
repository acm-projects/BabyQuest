import 'package:flutter/material.dart';
import 'package:tinycolor2/src/color_extension.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryVariant,
      //backgroundColor: Colors.white,
      body: Container(
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  AspectRatio(
                    aspectRatio: 39 / 30,
                    child: Stack(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.darken,
                          shaderCallback: (Rect bounds) => const LinearGradient(
                            colors: [Colors.transparent, Colors.black45],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds),
                          child: Container(
                            child: null,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                image: AssetImage('images/Osbaldo.jpg'),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  'Osbaldo Waldo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 40,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {},
                                color: Colors.white,
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        colorFilter: ColorFilter.mode(
                            Color(0x25FFFFFF), BlendMode.dstATop),
                        image: AssetImage('res/undraw_toy_car.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'General Information',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      const GeneralInfo(
                                        iconData: Icons.male,
                                        text: 'Male',
                                      ),
                                      const GeneralInfo(
                                        iconData: Icons.calendar_today,
                                        text: '14 months old',
                                      ),
                                      const GeneralInfo(
                                        iconData: Icons.monitor_weight_outlined,
                                        text: '20 pounds',
                                      ),
                                      const GeneralInfo(
                                        iconData: Icons.straighten,
                                        text: '2\'5"',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Allergies',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Divider(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Strawberries',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Latex',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Eggs',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Pediatric Information',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Doctor Name: Al Zeimers',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Phone: (555)-555-5555',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  LabeledIconButton(
                    icon: const Icon(Icons.logout),
                    textColor: Colors.red,
                    backgroundColor1: Colors.red,
                    backgroundColor2: Colors.red.brighten(35),
                    label: 'Sign Out',
                    onPressed: () {
                      
                    },
                  ),
                  const Spacer(),
                  LabeledIconButton(
                    icon: const Icon(Icons.phone),
                    textColor: Colors.orange,
                    backgroundColor1: Colors.orange,
                    backgroundColor2: Colors.orange.brighten(35),
                    label: 'Pediatrician',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  LabeledIconButton(
                    icon: const Icon(Icons.edit),
                    textColor: Colors.lightGreen,
                    backgroundColor1: Colors.lightGreen,
                    backgroundColor2: Colors.lightGreen.brighten(25),
                    label: 'Edit Info',
                    onPressed: () {},
                  ),
                  const Spacer(),
                  LabeledIconButton(
                    icon: const Icon(Icons.share),
                    textColor: Colors.lightBlueAccent,
                    backgroundColor1: Colors.lightBlueAccent,
                    backgroundColor2: Colors.lightBlueAccent.brighten(20),
                    label: 'Share Info',
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconInfo extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String label;

  const IconInfo({
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

class GeneralInfo extends StatelessWidget {
  const GeneralInfo({
    Key? key,
    required this.iconData,
    this.text = '',
  }) : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
              child:
                  Icon(iconData, color: Theme.of(context).colorScheme.primary),
              alignment: PlaceholderAlignment.middle),
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w400,
                fontSize: 15),
          )
        ],
      ),
    );
  }
}

class LabeledIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color iconColor;
  final Color textColor;
  final String label;

  const LabeledIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor1 = Colors.redAccent,
    this.backgroundColor2 = Colors.redAccent,
    this.iconColor = Colors.white,
    this.label = '',
    this.textColor = Colors.redAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [backgroundColor1, backgroundColor2],
              ),
              shape: const CircleBorder(),
            ),
            child: IconButton(
              iconSize: 30,
              padding: const EdgeInsets.all(10),
              color: iconColor,
              icon: icon,
              onPressed: onPressed,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor, fontSize: 10, fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
