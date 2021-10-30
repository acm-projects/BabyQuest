import 'package:client/models/baby_profile.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/widgets/dotted_divider.dart';
import 'package:client/widgets/edit_profile_widgets.dart';
import 'package:client/widgets/icon_information.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BabyProfile currentBby = BabyProfile.currentProfile;
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: BabyProfile.updateStream,
        builder: (context, snapshot) {
          return Column(
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
                            shaderCallback: (Rect bounds) =>
                                const LinearGradient(
                              colors: [Colors.transparent, Colors.black45],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: Container(
                              child: null,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(currentBby.profilePic),
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
                                    currentBby.name,
                                    style: const TextStyle(
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
                                  onPressed: () async {
                                    final name = TextEditingController(
                                        text: currentBby.name);

                                    await _showEditDialog(
                                      context: context,
                                      label: 'Baby Name',
                                      field: EditProfileWidgets.name(name),
                                      updateData: () => currentBby
                                          .updateData({'name': name.text}),
                                    );
                                  },
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
                                            .headline2),
                                  ),
                                  const DottedDivider(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconInformation(
                                              iconData: currentBby.genderIcon,
                                              topText: currentBby.gender,
                                              bottomText: 'Gender',
                                              enabled: editMode,
                                              onTap: () async {
                                                final gender =
                                                    TextEditingController(
                                                        text: currentBby
                                                            .genderRaw
                                                            .toString());

                                                await _showEditDialog(
                                                  context: context,
                                                  label: 'Gender',
                                                  field:
                                                      EditProfileWidgets.gender(
                                                          context, gender),
                                                  updateData: () => currentBby
                                                      .updateData({
                                                    'gender':
                                                        int.parse(gender.text)
                                                  }),
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            IconInformation(
                                              iconData:
                                                  Icons.monitor_weight_outlined,
                                              topText: currentBby.weight,
                                              bottomText: 'Weight',
                                              enabled: editMode,
                                              onTap: () async {
                                                final weightLb =
                                                    TextEditingController(
                                                        text: currentBby
                                                            .weightLb
                                                            .toString());
                                                final weightOz =
                                                    TextEditingController(
                                                        text: currentBby
                                                            .weightOz
                                                            .toString());

                                                await _showEditDialog(
                                                    context: context,
                                                    label: 'Weight',
                                                    field: EditProfileWidgets
                                                        .weight(
                                                            weightLb, weightOz),
                                                    updateData: () => currentBby
                                                            .updateData({
                                                          'weightLb':
                                                              double.parse(
                                                                  weightLb
                                                                      .text),
                                                          'weightOz':
                                                              double.parse(
                                                                  weightOz.text)
                                                        }));
                                              },
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
                                              enabled: editMode,
                                              onTap: () async {
                                                final birthDate =
                                                    TextEditingController(
                                                        text: currentBby
                                                            .birthDate
                                                            .toString());

                                                await _showEditDialog(
                                                    context: context,
                                                    label: 'Date of Birth',
                                                    field: EditProfileWidgets
                                                        .birthDate(
                                                            context, birthDate),
                                                    updateData: () => currentBby
                                                            .updateData({
                                                          'birth_date':
                                                              birthDate.text
                                                                  .split(' ')
                                                                  .first
                                                        }));
                                              },
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            IconInformation(
                                              iconData: Icons.straighten,
                                              topText: currentBby.height,
                                              bottomText: 'Height',
                                              enabled: editMode,
                                              onTap: () async {
                                                final height =
                                                    TextEditingController(
                                                        text: currentBby
                                                            .heightIn
                                                            .toString());

                                                await _showEditDialog(
                                                    context: context,
                                                    label: 'Height',
                                                    field: EditProfileWidgets
                                                        .height(height),
                                                    updateData: () => currentBby
                                                            .updateData({
                                                          'height':
                                                              double.parse(
                                                                  height.text)
                                                        }));
                                              },
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
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  const DottedDivider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      children: [
                                        IconInformation(
                                          iconData:
                                              Icons.medical_services_outlined,
                                          topText: currentBby.pediatrician,
                                          bottomText: 'Pediatrician',
                                          enabled: editMode,
                                          onTap: () async {
                                            final pediatrician =
                                                TextEditingController(
                                                    text: currentBby
                                                        .pediatrician);
                                            await _showEditDialog(
                                              context: context,
                                              label: 'Pediatrician Name',
                                              field: EditProfileWidgets
                                                  .pediatrician(pediatrician),
                                              updateData: () => currentBby
                                                  .updateData({
                                                'pediatrician':
                                                    pediatrician.text
                                              }),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        IconInformation(
                                          iconData: Icons.contacts_outlined,
                                          topText: currentBby.formattedPedPhone,
                                          bottomText: 'Phone',
                                          enabled: editMode,
                                          onTap: () async {
                                            final pedPhone =
                                                TextEditingController(
                                                    text: currentBby
                                                        .pediatricianPhone);

                                            await _showEditDialog(
                                                context: context,
                                                label: 'Pediatrician Phone',
                                                field: EditProfileWidgets
                                                    .pediatricianPhone(
                                                        pedPhone),
                                                updateData: () => currentBby
                                                        .updateData({
                                                      'pediatrician_phone':
                                                          pedPhone.text
                                                              .replaceAll(
                                                                  '-', '')
                                                    }));
                                          },
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
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  const DottedDivider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Column(
                                      children: [
                                        ..._buildAllergies(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const DottedDivider(),
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
                                    onPressed: () {
                                      launch('tel://' +
                                          currentBby.pediatricianPhone);
                                    },
                                  ),
                                  const Spacer(),
                                  LabeledIconButton(
                                    icon: const Icon(Icons.edit),
                                    label: 'Edit Info',
                                    onPressed: () => setState(() {
                                      editMode = !editMode;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          behavior: SnackBarBehavior.floating,
                                          duration: const Duration(
                                              milliseconds: 1250),
                                          content: Text(editMode
                                              ? 'Editing Enabled'
                                              : 'Editing Disabled'),
                                        ),
                                      );
                                    }),
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
          );
        },
      ),
    );
  }

  Future<void> _showEditDialog({
    required BuildContext context,
    required String label,
    required Widget field,
    required Function updateData,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          titlePadding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          title: Text(
            'Editing ' + label,
            style: Theme.of(context).textTheme.headline2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DottedDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Form(
                    key: _formKey,
                    child: field,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: SizedBox(
                width: 96,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const SizedBox(
                width: 96,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Save',
                    ),
                  ),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateData();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
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
          enabled: editMode,
          onTap: () async {
            List<String> allergyNames = currentBby.allergies.keys.toList();
            List<int> allergySeverities = currentBby.allergies.values.toList();

            await _showEditDialog(
              context: context,
              label: 'Allergies',
              field: EditProfileWidgets.allergies(allergyNames, allergySeverities),
              updateData: () =>
                  currentBby.updateData({'allergies': Map.fromIterables(allergyNames, allergySeverities)}),
            );
          },
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
              splashColor: Theme.of(context).colorScheme.primary,
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
