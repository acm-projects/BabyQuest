import 'package:client/services/auth_service.dart';
import 'package:client/widgets/icon_information.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/models/baby_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  BabyProfile currentBby = BabyProfile.currentProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: Text(
                                currentBby.fullName,
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
                                    style:
                                        Theme.of(context).textTheme.headline2),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                                      children: [
                                        IconInformation(
                                          iconData: Icons.male,
                                          topText: currentBby.gender,
                                          bottomText: 'Gender',
                                        ),
                                        const SizedBox(
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
                                      children: [
                                        IconInformation(
                                          iconData: Icons.calendar_today,
                                          topText: currentBby.age,
                                          bottomText: 'Age',
                                        ),
                                        const SizedBox(
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
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  children: const [
                                    IconInformation(
                                      iconData: Icons.medical_services_outlined,
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
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              Divider(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  children: [
                                    ..._buildAllergies(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 16, bottom: 32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              LabeledIconButton(
                                icon: const Icon(Icons.logout),
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
                                label: 'Pediatrician',
                                onPressed: () {},
                              ),
                              const Spacer(),
                              LabeledIconButton(
                                icon: const Icon(Icons.edit),
                                label: 'Edit Info',
                                onPressed: () {
                                  /*go to data input page with existing profile info filled in
                                  pass profile from here? pass a bool saying editing not creating new profile.
                                  so if editing, pass profile into controller
                                  use .fromValue on controllers
                                  when submit is hit, if editing then return to profile page - nav push replacement?
                                   */
                                },
                              ),
                              const Spacer(),
                              LabeledIconButton(
                                icon: const Icon(Icons.share),
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
    );
  }

  List<Widget> _buildAllergies() {
    List<String> severities = ['Mild', 'Moderate', 'Severe'];
    List<Widget> allergies = [];

    currentBby.allergies.forEach((String allergy, int severity) {
      allergies.add(
        IconInformation(
          iconData: Icons.warning_amber_outlined,
          topText: allergy,
          bottomText: severities[severity],
        ),
      );

      allergies.add(const SizedBox(
        height: 32,
      ));
    });

    if (allergies.isNotEmpty) {
      allergies.removeLast();
    }

    return allergies;
  }
}

class LabeledIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final String label;

  const LabeledIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.label = '',
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? Theme.of(context).colorScheme.secondary;
    final Color iconColor =
        this.iconColor ?? Theme.of(context).colorScheme.onSecondary;
    final Color textColor =
        this.textColor ?? Theme.of(context).colorScheme.onBackground;

    return Column(
      children: [
        Center(
          child: Container(
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: const CircleBorder(),
            ),
            child: IconButton(
              iconSize: 30,
              padding: const EdgeInsets.all(12),
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
