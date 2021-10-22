import 'package:client/services/auth_service.dart';
import 'package:client/widgets/icon_information.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor2/tinycolor2.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                image: AssetImage('assets/images/Osbaldo.jpg'),
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
                                padding: const EdgeInsets.only(left: 16),
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
                        image: AssetImage('assets/images/undraw_toy_car.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
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
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          IconInformation(
                                            iconData: Icons.male,
                                            topText: 'Male',
                                            bottomText: 'Gender',
                                          ),
                                          SizedBox(
                                            height: 32,
                                          ),
                                          IconInformation(
                                            iconData:
                                                Icons.monitor_weight_outlined,
                                            topText: '20 pounds',
                                            bottomText: 'Weight',
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          IconInformation(
                                            iconData: Icons.calendar_today,
                                            topText: '14 months old',
                                            bottomText: 'Age',
                                          ),
                                          SizedBox(
                                            height: 32,
                                          ),
                                          IconInformation(
                                            iconData: Icons.straighten,
                                            topText: '2\'5"',
                                            bottomText: 'Height',
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
                            padding: const EdgeInsets.only(top: 16),
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
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    children: const [
                                      IconInformation(
                                        iconData:
                                            Icons.medical_services_outlined,
                                        topText: 'Al Zeimers',
                                        bottomText: 'Doctor',
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      IconInformation(
                                        iconData: Icons.contacts_outlined,
                                        topText: '(555)-555-5555',
                                        bottomText: 'Phone',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
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
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    children: const [
                                      IconInformation(
                                        iconData: Icons.warning_amber_outlined,
                                        topText: 'Latex',
                                        bottomText: 'Extreme',
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      IconInformation(
                                        iconData: Icons.warning_amber_outlined,
                                        topText: 'Strawberries',
                                        bottomText: 'Mild',
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      IconInformation(
                                        iconData: Icons.warning_amber_outlined,
                                        topText: 'Eggs',
                                        bottomText: 'Mild',
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
                                left: 32, right: 32, top: 16, bottom: 16),
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
