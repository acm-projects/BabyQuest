import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:client/models/app_user.dart';
import 'package:client/widgets/edit_profile_widgets.dart';

class CreateProfilePage extends StatefulWidget {
  final Function completed;

  const CreateProfilePage(this.completed, {Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int _currentStep = 0;

  //text editing controllers
  final name = TextEditingController();
  final birthDate = TextEditingController();
  final gender = TextEditingController();
  final heightIn = TextEditingController();
  final weightLb = TextEditingController();
  final weightOz = TextEditingController();
  final pedName = TextEditingController();
  final pedPhone = TextEditingController();
  final image = TextEditingController();

  List<String> allergyNames = [''];
  List<int> allergySeverities = [-1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile Data Input'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                return Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      if (_currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('Back'),
                            onPressed: onStepCancel,
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          child:
                              Text(_currentStep == 2 ? 'Submit' : 'Continue'),
                          onPressed: onStepContinue,
                        ),
                      ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('General Information'),
                  content: Form(
                    key: _formKeys[0],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditProfileWidgets.name(name),
                        const SizedBox(height: 12),
                        EditProfileWidgets.birthDate(context, birthDate),
                        const SizedBox(height: 12),
                        EditProfileWidgets.gender(gender),
                        const SizedBox(height: 12),
                        EditProfileWidgets.height(heightIn),
                        const SizedBox(height: 12),
                        EditProfileWidgets.weight(weightLb, weightOz),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Medical Information'),
                  content: Form(
                    key: _formKeys[1],
                    child: Column(
                      children: [
                        EditProfileWidgets.allergies(
                            allergyNames, allergySeverities),
                        EditProfileWidgets.pediatrician(pedName),
                        EditProfileWidgets.pediatricianPhone(pedPhone),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Profile Picture'),
                  content: Form(
                    key: _formKeys[2],
                    child: EditProfileWidgets.profilePicture(image),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    if (!_formKeys[_currentStep].currentState!.validate()) return;

    if (_currentStep == 2) {
      if (AppUser.currentUser != null) {
        AppUser.currentUser!.createNewProfile(
          name: name.text,
          birthDate: DateTime.parse(birthDate.text),
          gender: int.parse(gender.text),
          height: double.parse(heightIn.text),
          weightLb: double.parse(weightLb.text),
          weightOz: double.parse(weightOz.text),
          pediatrician: pedName.text,
          pediatricianPhone: pedPhone.text.replaceAll('-', ''),
          allergies: Map.fromIterables(allergyNames, allergySeverities),
          imagePath: image.text,
        );
      }

      widget.completed();
    } else {
      setState(() => _currentStep += 1);
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
