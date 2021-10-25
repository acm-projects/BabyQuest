import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataInput extends StatefulWidget {
  const DataInput({Key? key}) : super(key: key);

  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  DateTime selectedDate = DateTime.now();
  String dropdownValue = 'Choose';
  var items = ['Choose','Male','Female'];
  String newValue = 'Choose';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('User Data Input'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: new Text('General Information'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'First Name'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Last Name'),
                        ),
                        Text('Select Gender of child:'),
                        DropdownButton(
                          value: dropdownValue,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items:items.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text(items)
                            );
                          }
                          ).toList(),
                          onChanged: (newValue){
                            setState(() {
                              dropdownValue = newValue.toString();
                            });
                          },
                        ),
                        Text('Height'),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Feet'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Inches'),
                        ),
                        Text('Date of Birth:'),
                        ElevatedButton(
                          onPressed: () => _selectDate(context), // Refer step 3
                          child: Text(
                            'Select Date of Birth',
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
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Medical Information'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Allergies'),
                        ),
                        TextFormField(
                          decoration:
                          InputDecoration(labelText: 'Name of Doctor'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Doctor Contact Information'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Profile Picture'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          InputDecoration(labelText: 'Mobile Number'),
                        ),
                      ],
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
      ),
    );
  }


  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
