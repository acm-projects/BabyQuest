import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color detailsIconsColor = Color(0xFF9E9E9E);
  static const Color detailsTextColor = Color(0x8A000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFeaf8da),
      backgroundColor: Color(0x1100FF00),
      //backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: RichText(
                                text: const TextSpan(
                                  text: 'General Information',
                                  style: TextStyle(
                                      color: detailsTextColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            const Divider(
                              color: detailsTextColor,
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Icon(Icons.male,
                                          color: detailsIconsColor),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: 'Male',
                                    style: TextStyle(
                                        color: detailsTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Icon(Icons.calendar_today,
                                          color: detailsIconsColor),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: '14 months old',
                                    style: TextStyle(
                                        color: detailsTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Icon(Icons.monitor_weight_outlined,
                                          color: detailsIconsColor),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: '20 pounds',
                                    style: TextStyle(
                                        color: detailsTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Icon(Icons.straighten,
                                          color: detailsIconsColor),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(
                                    text: '2\'5"',
                                    style: TextStyle(
                                        color: detailsTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  )
                                ],
                              ),
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
                              text: const TextSpan(
                                text: 'Allergies',
                                style: TextStyle(
                                    color: detailsTextColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15),
                              ),
                            ),
                            const Divider(
                              color: detailsTextColor,
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Strawberries',
                                style: TextStyle(
                                    color: detailsTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Latex',
                                style: TextStyle(
                                    color: detailsTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Eggs',
                                style: TextStyle(
                                    color: detailsTextColor,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Pediatric Information',
                            style: TextStyle(
                                color: detailsTextColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      const Divider(
                        color: detailsTextColor,
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Doctor Name: Al Zeimers',
                          style: TextStyle(
                              color: detailsTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Phone: (555)-555-5555',
                          style: TextStyle(
                              color: detailsTextColor,
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                LabeledIconButton(
                  icon: const Icon(Icons.phone),
                  textColor: Colors.redAccent,
                  backgroundColor1: Colors.redAccent,
                  backgroundColor2: const Color(0xFFff51a5),
                  label: 'Pediatrician',
                  onPressed: () {},
                ),
                const Spacer(),
                LabeledIconButton(
                  icon: const Icon(Icons.logout),
                  textColor: Colors.orange,
                  backgroundColor1: Colors.orange,
                  backgroundColor2: const Color(0xFFffd900),
                  label: 'Sign Out',
                  onPressed: () {},
                ),
                const Spacer(),
                LabeledIconButton(
                  icon: const Icon(Icons.edit),
                  textColor: Colors.lightGreen,
                  backgroundColor1: Colors.lightGreen,
                  backgroundColor2: const Color(0xFF63f05b),
                  label: 'Edit Info',
                  onPressed: () {},
                ),
                const Spacer(),
                LabeledIconButton(
                  icon: const Icon(Icons.share),
                  textColor: Colors.blue,
                  backgroundColor1: Colors.blue,
                  backgroundColor2: const Color(0xff9cc7ff),
                  label: 'Share Info',
                  onPressed: () {},
                ),
              ],
            ),
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
        Ink(
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
