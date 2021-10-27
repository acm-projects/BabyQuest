import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:client/models/app_user.dart';

class DataInput extends StatefulWidget {
  final Function completed;

  const DataInput(this.completed, {Key? key}) : super(key: key);

  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  DateTime birthDate = DateTime.now();
  String dropdownValue = 'Choose';
  var items = ['Choose', 'Male', 'Female'];
  String newValue = 'Choose';

  //text editing controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final heightFt = TextEditingController();
  final heightIn = TextEditingController();
  final allergies = TextEditingController();
  final pedName = TextEditingController();
  final pedPhone = TextEditingController();
  final image = TextEditingController();

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
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'First Name'),
                        controller: firstName,
                      ),
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Last Name'),
                        controller: lastName,
                      ),
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
                        decoration: const InputDecoration(labelText: 'Feet'),
                        controller: heightFt,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Inches'),
                        controller: heightIn,
                      ),
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
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Medical Information'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Allergies'),
                        controller: allergies,
                      ),
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Name of Doctor'),
                        controller: pedName,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Doctor Contact Information'),
                        controller: pedPhone,
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Profile Picture'),
                  content: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                        const InputDecoration(labelText: 'Image URL'),
                        controller: image,
                      ),
                    ],
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
    if (_currentStep == 2) {
      if (AppUser.currentUser != null) {
        double height =
            (double.parse(heightFt.text) * 12) + double.parse(heightIn.text);

        AppUser.currentUser!.createNewProfile(
            firstName: firstName.text,
            lastName: lastName.text,
            birthDate: birthDate,
            gender: items.indexOf(dropdownValue) - 1,
            height: height,
            weight: 0.0, // TODO
            pediatrician: pedName.text,
            pediatricianPhone: pedPhone.text,
            allergies: {});
      }

      widget.completed();
    } else {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
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