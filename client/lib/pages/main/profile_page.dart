import 'package:client/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                                image: AssetImage('res/Osbaldo.jpg'),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'General Information',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1),
                                ),
                                Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  thickness: 1,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          IconInfo(
                                            iconData: Icons.male,
                                            text: 'Male',
                                            label: 'Gender',
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconInfo(
                                            iconData:
                                                Icons.monitor_weight_outlined,
                                            text: '20 pounds',
                                            label: 'Weight',
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          IconInfo(
                                            iconData: Icons.calendar_today,
                                            text: '14 months old',
                                            label: 'Age',
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconInfo(
                                            iconData: Icons.straighten,
                                            text: '2\'5"',
                                            label: 'Height',
                                          )
                                        ],
                                      ),
                                      const Spacer()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Pediatric Information',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: const [
                                      IconInfo(
                                        iconData:
                                            Icons.medical_services_outlined,
                                        text: 'Al Zeimers',
                                        label: 'Doctor',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconInfo(
                                        iconData: Icons.contacts_outlined,
                                        text: '(555)-555-5555',
                                        label: 'Phone',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Allergies',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryVariant,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children: const [
                                      IconInfo(
                                        iconData: Icons.warning_amber_outlined,
                                        text: 'Latex',
                                        label: 'Extreme',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconInfo(
                                        iconData: Icons.warning_amber_outlined,
                                        text: 'Strawberries',
                                        label: 'Mild',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconInfo(
                                        iconData: Icons.warning_amber_outlined,
                                        text: 'Eggs',
                                        label: 'Mild',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20, bottom: 20),
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
                                    final provider = Provider.of<AuthService>(
                                        context,
                                        listen: false);
                                    provider.signOut();
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
                                  backgroundColor2:
                                      Colors.lightGreen.brighten(25),
                                  label: 'Edit Info',
                                  onPressed: () {},
                                ),
                                const Spacer(),
                                LabeledIconButton(
                                  icon: const Icon(Icons.share),
                                  textColor: Colors.lightBlueAccent,
                                  backgroundColor1: Colors.lightBlueAccent,
                                  backgroundColor2:
                                      Colors.lightBlueAccent.brighten(20),
                                  label: 'Share Info',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                style: Theme.of(context).textTheme.headline1,
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                  text: label, style: Theme.of(context).textTheme.subtitle1)
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
