import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:client/models/app_user.dart';
import 'package:client/pages/main/user_input_widgets.dart';

class DataInput extends StatefulWidget {
  final Function completed;

  const DataInput(this.completed, {Key? key}) : super(key: key);

  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  static List<String> allergyNames = [''];
  static List<int> allergySeverities = [-1];

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  String dropdownValue = 'Choose';
  var items = ['Choose', 'Male', 'Female'];
  String newValue = 'Choose';

  //text editing controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final birthDate = TextEditingController();
  final heightIn = TextEditingController();
  final weightLb = TextEditingController();
  final weightOz = TextEditingController();
  final pedName = TextEditingController();
  final pedPhone = TextEditingController();
  final image = TextEditingController();

  String? _imagePath;

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
              type: stepperType,
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
                      children: [
                        ...UserInputWidgets.name(firstName, lastName),
                        const SizedBox(height: 12),
                        ...UserInputWidgets.birthDate(
                            context, setState, birthDate),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('Select Gender of child:'), // TODO
                            const SizedBox(width: 50),
                            Expanded(
                              child: DropdownButton(
                                value: dropdownValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...UserInputWidgets.height(heightIn),
                        const SizedBox(height: 12),
                        ...UserInputWidgets.weight(weightLb, weightOz),
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
                        ..._buildAllergyFields(), // TODO
                        ...UserInputWidgets.pediatrician(pedName),
                        ...UserInputWidgets.pediatricianPhone(pedPhone),
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
                    child: Column(
                      children: [
                        ..._getImage(),
                        ElevatedButton(
                          onPressed: () => _pickImage(),
                          child: const Text(
                            'Select profile picture',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
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

  List<Widget> _getImage() {
    if (_imagePath != null) {
      return [Image.file(File(_imagePath!))];
    }

    return [];
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  Future _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => _imagePath = pickedFile.path);
    }
  }

  continued() {
    if (_currentStep == 2 && _formKeys[_currentStep].currentState!.validate()) {
      if (AppUser.currentUser != null) {
        double height = double.parse(heightIn.text);
        double lbs = double.parse(weightLb.text);
        double oz = double.parse(weightOz.text);

        Map<String, int> allergies =
            Map.fromIterables(allergyNames, allergySeverities);

        String pedPhoneRaw = pedPhone.text.replaceAll('-', '');

        AppUser.currentUser!.createNewProfile(
            firstName: firstName.text,
            lastName: lastName.text,
            birthDate: DateTime.parse(birthDate.text),
            gender: items.indexOf(dropdownValue) - 1,
            height: height,
            weightLb: lbs,
            weightOz: oz,
            pediatrician: pedName.text,
            pediatricianPhone: pedPhoneRaw,
            allergies: allergies,
            imagePath: _imagePath!,
        );
      }

      widget.completed();
    } else {
      //_currentStep < 2 ? setState(() => _currentStep += 1) : null;
      setState(() {
        if (_formKeys[_currentStep].currentState!.validate()) {
          _currentStep += 1;
        }
      });
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  List<Widget> _buildAllergyFields() {
    List<Widget> allergyFields = [];

    for (int i = 0; i < allergyNames.length; i++) {
      allergyFields.add(AllergyInputField(i));
    }

    allergyFields.add(ElevatedButton(
      child: const Text('Add another allergy'),
      onPressed: () {
        setState(() {
          allergyNames.add('');
          allergySeverities.add(-1);
        });
      },
    ));

    return allergyFields;
  }
}

class AllergyInputField extends StatefulWidget {
  final int index;

  const AllergyInputField(this.index, {Key? key}) : super(key: key);

  @override
  _AllergyInputFieldState createState() => _AllergyInputFieldState();
}

class _AllergyInputFieldState extends State<AllergyInputField> {
  String dropdownValue = 'Select';
  var items = ['Select', 'Mild', 'Moderate', 'Severe'];

  final allergy = TextEditingController();

  @override
  Widget build(BuildContext context) {
    allergy.text = _DataInputState.allergyNames[widget.index];
    dropdownValue = items[_DataInputState.allergySeverities[widget.index] + 1];

    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Allergies'),
            controller: allergy,
            onChanged: (newValue) {
              _DataInputState.allergyNames[widget.index] = newValue.toString();
            },
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue.toString();
              _DataInputState.allergySeverities[widget.index] =
                  items.indexOf(dropdownValue) - 1;
            });
          },
        ),
      ],
    );
  }
}
