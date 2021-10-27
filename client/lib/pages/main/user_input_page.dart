import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:client/models/app_user.dart';
import 'package:client/models/baby_profile.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DataInput extends StatefulWidget {
  final Function completed;
  final bool editing;

  const DataInput(this.completed, {this.editing = false, Key? key}) : super(key: key);

  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  static final _database = FirebaseFirestore.instance;
  BabyProfile currentBby = BabyProfile.currentProfile;

  final List<GlobalKey<FormState>> _formKeys =
  [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  DateTime birthDate = DateTime.now();
  String dropdownValue = 'Choose';
  var items = ['Choose', 'Male', 'Female'];
  String newValue = 'Choose';

  //text editing controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final heightIn = TextEditingController();
  final weightLb = TextEditingController();
  final weightOz = TextEditingController();
  final allergies = TextEditingController();
  final pedName = TextEditingController();
  final pedPhone = TextEditingController();
  final image = TextEditingController();

  @override
  void initState() {
    if (widget.editing) {
      firstName.text = currentBby.firstName;
      lastName.text = currentBby.lastName;
      heightIn.text = currentBby.height.toString();
      weightLb.text = currentBby.weightLb.toString();
      weightOz.text = currentBby.weightOz.toString();
      allergies.text = currentBby.achooList;
      pedName.text = currentBby.pediatrician;
      pedPhone.text = currentBby.pediatricianPhone;
      image.text = currentBby.profilePic;
    }
    // TODO: implement initState
    super.initState();

  }

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
              steps: <Step>[
                Step(
                  title: const Text('General Information'),
                  content: Form(
                    key: _formKeys[0],
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'First Name'),
                          controller: firstName,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter the first name'
                                : null;
                          },
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Last Name'),
                          controller: lastName,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter the last name'
                                : null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text('Date of Birth:'),
                        ElevatedButton(
                          onPressed: () => _selectDate(context), // Refer step 3
                          child: const Text(
                            'Select Date of Birth',
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Select Gender of child:'),
                        DropdownButton(
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
                        const Text('Height'),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Inches'),
                          keyboardType: TextInputType.number,
                          controller: heightIn,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter the height (in)'
                                : null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text('Weight',),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Pounds'),
                                keyboardType: TextInputType.number,
                                controller: weightLb,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Enter the weight (lbs)'
                                      : null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Ounces'),
                                keyboardType: TextInputType.number,
                                controller: weightOz,
                                validator: (value) {
                                  return (value == null || value.isEmpty)
                                      ? 'Enter the weight (oz)'
                                      : null;
                                },
                              ),
                            ),
                          ],
                        ),
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
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Allergies - enter as allergy, severity, ... or None'),
                          controller: allergies,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter your child\'s allergies or type None' : null;
                          },
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Name of Doctor'),
                          controller: pedName,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter your pediatrician\'s name' : null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Doctor Contact Information'),
                          keyboardType: TextInputType.phone,
                          controller: pedPhone,
                          validator: (value) {
                            return (value == null || value.length != 10)
                                ? 'Enter a valid phone number'
                                : null;
                          },
                        ),
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
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Image URL'),
                          controller: image,
                          validator: (value) {
                            return (value == null || value.isEmpty)
                                ? 'Enter an image URL'
                                : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
                /*Step(
                    title: Text('Confirm Submission'),
                    content
                  ),*/
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
    if (_currentStep == 2 && _formKeys[_currentStep].currentState!.validate()) {
      if (AppUser.currentUser != null) {
        double height = double.parse(heightIn.text);
        double lbs = double.parse(weightLb.text);
        double oz = double.parse(weightOz.text);
        List<String> achoo = allergies.text.split(',');

        AppUser.currentUser!.createNewProfile(
            firstName: firstName.text,
            lastName: lastName.text,
            birthDate: birthDate,
            gender: items.indexOf(dropdownValue) - 1,
            height: height,
            weightLb: lbs,
            weightOz: oz,
            pediatrician: pedName.text,
            pediatricianPhone: pedPhone.text,
            allergies: achoo);
      }

      if (widget.editing) {
        //pass in new profile info
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }
}