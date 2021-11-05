import 'package:client/models/app_user.dart';
import 'package:client/models/baby_profile.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/widgets/dotted_divider.dart';
import 'package:client/widgets/edit_profile_widgets.dart';
import 'package:client/widgets/icon_information.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final Function creatingNewProfile;
  final Function refresh;

  const ProfilePage(this.creatingNewProfile, this.refresh, {Key? key})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BabyProfile currentBby = BabyProfile.currentProfile;
  bool editMode = false;
  final isDialOpen = ValueNotifier(false);
  final openCloseDial = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: ListView(
            children: _buildProfiles(),
          ),
        ),
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
                        child: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Stack(
                              children: [
                                ShaderMask(
                                  blendMode: BlendMode.darken,
                                  shaderCallback: (Rect bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black45
                                    ],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    fit: BoxFit.cover,
                                    height: constraints.maxHeight,
                                    alignment: Alignment.topCenter,
                                    imageUrl: currentBby.profilePic,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 16),
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
                                    if (editMode)
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            final name = TextEditingController(
                                                text: currentBby.name);
                                            final image = TextEditingController(
                                                text: currentBby.profilePic);

                                            await _showEditDialog(
                                              context: context,
                                              label: 'Baby Name',
                                              field: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  EditProfileWidgets.name(
                                                      name, false),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  EditProfileWidgets
                                                      .profilePicture(image),
                                                ],
                                              ),
                                              updateData: () {
                                                currentBby.updateData(
                                                    {'name': name.text});
                                                if (image.text !=
                                                    currentBby.profilePic) {
                                                  currentBby.updateProfileImage(
                                                      image.text);
                                                }
                                              },
                                            );
                                          },
                                          color: Colors.white,
                                          icon: const Icon(Icons.edit),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            colorFilter: ColorFilter.mode(
                                Color(0x25FFFFFF), BlendMode.dstATop),
                            image:
                                AssetImage('assets/images/undraw_toy_car.png'),
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
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconInformation(
                                                  iconData:
                                                      currentBby.genderIcon,
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
                                                      field: EditProfileWidgets
                                                          .gender(
                                                              context, gender),
                                                      updateData: () =>
                                                          currentBby
                                                              .updateData({
                                                        'gender': int.parse(
                                                            gender.text)
                                                      }),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 32,
                                                ),
                                                IconInformation(
                                                  iconData: Icons
                                                      .monitor_weight_outlined,
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
                                                        field:
                                                            EditProfileWidgets
                                                                .weight(
                                                                    weightLb,
                                                                    weightOz),
                                                        updateData: () =>
                                                            currentBby
                                                                .updateData({
                                                              'weightLb':
                                                                  double.parse(
                                                                      weightLb
                                                                          .text),
                                                              'weightOz':
                                                                  double.parse(
                                                                      weightOz
                                                                          .text)
                                                            }));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconInformation(
                                                  iconData:
                                                      Icons.calendar_today,
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
                                                        field:
                                                            EditProfileWidgets
                                                                .birthDate(
                                                                    context,
                                                                    birthDate),
                                                        updateData: () =>
                                                            currentBby
                                                                .updateData({
                                                              'birth_date':
                                                                  birthDate.text
                                                                      .split(
                                                                          ' ')
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
                                                        field:
                                                            EditProfileWidgets
                                                                .height(height),
                                                        updateData: () =>
                                                            currentBby
                                                                .updateData({
                                                              'height':
                                                                  double.parse(
                                                                      height
                                                                          .text)
                                                            }));
                                                  },
                                                )
                                              ],
                                            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Pediatric Information',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
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
                                            topText:
                                                currentBby.formattedPedPhone,
                                            bottomText: 'Phone',
                                            enabled: editMode,
                                            onTap: () async {
                                              final pedPhone =
                                                  TextEditingController(
                                                      text: currentBby
                                                          .formattedPedPhone
                                                          .replaceAll('(', '')
                                                          .replaceAll(
                                                              ') ', '-'));
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
                              if (_buildAllergies().isNotEmpty || editMode)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Allergies',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                      const DottedDivider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Column(
                                          children: [
                                            ..._buildAllergies(),
                                            if (_buildAllergies().isEmpty)
                                              Center(
                                                child: InkWell(
                                                  onTap: () async {
                                                    List<String> allergyNames =
                                                        currentBby
                                                            .allergies.keys
                                                            .toList();
                                                    List<int>
                                                        allergySeverities =
                                                        currentBby
                                                            .allergies.values
                                                            .toList();
                                                    List<int> remove = [];

                                                    await _showEditDialog(
                                                      context: context,
                                                      label: 'Allergies',
                                                      field: EditProfileWidgets
                                                          .allergies(
                                                              allergyNames,
                                                              allergySeverities,
                                                              remove),
                                                      updateData: () {
                                                        for (var index in remove
                                                            .reversed) {
                                                          allergyNames
                                                              .removeAt(index);
                                                          allergySeverities
                                                              .removeAt(index);
                                                        }

                                                        currentBby.updateData({
                                                          'allergies':
                                                              Map.fromIterables(
                                                                  allergyNames,
                                                                  allergySeverities)
                                                        });
                                                      },
                                                    );
                                                  },
                                                  splashColor: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    child: Text(
                                                      'Add Allergies',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 48,
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
        floatingActionButton: SpeedDial(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black,
          overlayOpacity: .2,
          spacing: 12,
          spaceBetweenChildren: 12,
          buttonSize: 64,
          childrenButtonSize: 64,
          openCloseDial: isDialOpen,
          animationSpeed: 0,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.logout),
              label: 'Sign Out',
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onTap: () {
                final provider =
                    Provider.of<AuthService>(context, listen: false);
                provider.signOut();
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.phone),
              label: 'Pediatrician',
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onTap: () {
                launch('tel://' + currentBby.pediatricianPhone);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.edit),
              label: 'Edit Info',
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onTap: () => setState(() {
                editMode = !editMode;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(milliseconds: 1250),
                    content:
                        Text(editMode ? 'Editing Enabled' : 'Editing Disabled'),
                  ),
                );
              }),
            ),
            SpeedDialChild(
              child: const Icon(Icons.share),
              label: 'Share',
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onTap: () async {
                Map<String, String> newUsers = {};
                List<String> removedUsers = [];

                await _showEditDialog(
                  context: context,
                  label: 'Share Settings',
                  field: await EditProfileWidgets.shareProfile(currentBby.uid,
                      AppUser.currentUser?.email ?? '', newUsers, removedUsers),
                  updateData: () {
                    currentBby.updatePermissions(newUsers, removedUsers);
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const FaIcon(FontAwesomeIcons.baby),
              label: 'Switch Baby',
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onTap: () async {},
            ),
          ],
        ),
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
          titlePadding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          title: Text(
            'Editing ' + label,
            style: Theme.of(context).textTheme.headline2,
          ),
          content: SingleChildScrollView(
            child: Column(
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
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: SizedBox(
                width: 64,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 16,
            ),
            OutlinedButton(
              child: SizedBox(
                width: 64,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.headline3,
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
            List<int> remove = [];

            await _showEditDialog(
              context: context,
              label: 'Allergies',
              field: EditProfileWidgets.allergies(
                  allergyNames, allergySeverities, remove),
              updateData: () {
                for (var index in remove.reversed) {
                  allergyNames.removeAt(index);
                  allergySeverities.removeAt(index);
                }

                currentBby.updateData({
                  'allergies':
                      Map.fromIterables(allergyNames, allergySeverities)
                });
              },
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

  List<Widget> _buildShareProfile() {
    if (AppUser.currentUser != null &&
        !AppUser.currentUser!.ownedProfiles.contains(currentBby.uid)) return [];

    return [
      const Spacer(),
      LabeledIconButton(
        icon: const Icon(Icons.share),
        label: 'Share Info',
        onPressed: () async {
          Map<String, String> newUsers = {};
          List<String> removedUsers = [];

          await _showEditDialog(
            context: context,
            label: 'Share Settings',
            field: await EditProfileWidgets.shareProfile(currentBby.uid,
                AppUser.currentUser?.email ?? '', newUsers, removedUsers),
            updateData: () {
              currentBby.updatePermissions(newUsers, removedUsers);
            },
          );
        },
      ),
    ];
  }

  Widget _buildProfileButton(String profileId, bool shared) {
    String profileName = AppUser.currentUser!.profileNames[profileId] ?? '';

    return ListTile(
      title: Text(profileName),
      subtitle: shared ? const Text('Shared with you') : null,
      onTap: () async {
        Navigator.pop(context);
        AppUser.currentUser?.setCurrentProfile(profileId);
        widget.refresh();
      },
    );
  }

  List<Widget> _buildProfiles() {
    List<Widget> profiles = [];

    if (AppUser.currentUser != null) {
      for (var profileId in AppUser.currentUser!.ownedProfiles) {
        profiles.add(_buildProfileButton(profileId, false));
      }

      for (var profileId in AppUser.currentUser!.sharedProfiles) {
        profiles.add(_buildProfileButton(profileId, true));
      }
    }

    profiles.add(ListTile(
      title: const Text('Create New Profile'),
      onTap: () async {
        Navigator.pop(context);
        widget.creatingNewProfile(finished: false);
      },
    ));

    return profiles;
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
