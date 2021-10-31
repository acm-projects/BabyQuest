import 'dart:io';

import 'package:client/models/baby_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidgets {
  static Widget name(TextEditingController nameController) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter baby\'s full name'
              : null;
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.edit),
          labelText: 'Baby\'s Full Name',
        ),
      ),
    );
  }

  static _selectDate(
      TextEditingController birthDateController, BuildContext context) async {
    DateTime initialDate;

    if (birthDateController.text.isNotEmpty) {
      initialDate = DateTime.parse(birthDateController.text);
    } else {
      initialDate = DateTime.now();
    }

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (selectedDate != null &&
        selectedDate.toString() != birthDateController.text) {
      birthDateController.text = selectedDate.toString();
    }
  }

  static String _getFormattedDate(TextEditingController birthDateController) {
    if (birthDateController.text.isNotEmpty) {
      DateTime unformattedDate = DateTime.parse(birthDateController.text);
      return '${unformattedDate.month}/${unformattedDate.day}/${unformattedDate.year}';
    }

    return 'Select Date of Birth';
  }

  static Widget birthDate(
      BuildContext context, TextEditingController birthDateController) {
    final viewController = TextEditingController();
    viewController.text = _getFormattedDate(birthDateController);

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: 256,
          child: TextFormField(
            controller: viewController,
            readOnly: true,
            validator: (value) {
              return (value == null ||
                      value.isEmpty ||
                      value == 'Select Date of Birth')
                  ? 'Select baby\'s date of birth'
                  : null;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              await _selectDate(birthDateController, context);
              setState(() =>
                  viewController.text = _getFormattedDate(birthDateController));
            },
          ),
        );
      },
    );
  }

  static Widget gender(
      BuildContext context, TextEditingController genderController) {
    var items = ['Male', 'Female', 'Other'];

    return Row(
      children: [
        Icon(
          BabyProfile.getGenderIcon(
            int.tryParse(genderController.text) ?? 3,
          ),
          color: const Color(0xFF8C8161),
          size: 17,
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          width: 120,
          child: DropdownButtonFormField(
            hint: const Text('Gender'),
            value: (int.tryParse(genderController.text) != null)
                ? items[int.parse(genderController.text)]
                : null,
            style: Theme.of(context).textTheme.subtitle1,
            autofocus: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF8C8161),
            ),
            items: items.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (newValue) {
              genderController.text =
                  items.indexOf(newValue.toString()).toString();
            },
            validator: (value) {
              return (value == null) ? 'Select baby\'s gender' : null;
            },
          ),
        ),
      ],
    );
  }

  static Widget height(TextEditingController heightController) {
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: heightController,
            validator: (value) {
              return (value == null || value.isEmpty) ? '' : null;
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.straighten),
              hintText: '24',
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 6),
            ),
          ),
        ),
        const Text('in'),
      ],
    );
  }

  static Widget weight(TextEditingController weightLbController,
      TextEditingController weightOzController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: weightLbController,
            validator: (value) {
              return (value == null || value.isEmpty) ? '' : null;
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.monitor_weight_outlined),
              hintText: '12',
              contentPadding: EdgeInsets.only(bottom: 6),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Text('lbs'),
        ),
        SizedBox(
          width: 80,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: weightOzController,
            validator: (value) {
              return (value == null || value.isEmpty) ? '' : null;
            },
            decoration: const InputDecoration(
              icon: Icon(
                Icons.monitor_weight_outlined,
                color: Colors.transparent,
              ),
              hintText: '3',
              contentPadding: EdgeInsets.only(bottom: 6),
            ),
          ),
        ),
        const Text('oz'),
      ],
    );
  }

  static Widget _allergyField(int index, List<String> allergyNames,
      List<int> allergySeverities, List<int> remove, Function setState) {
    var items = ['Mild', 'Moderate', 'Severe'];

    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 16,
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                allergyNames.removeAt(index);
                allergySeverities.removeAt(index);
              });
            },
          ),
          Expanded(
            child: TextFormField(
                initialValue: allergyNames[index],
                decoration: InputDecoration(
                    labelText: 'Allergy ${index + 1}',
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 6)),
                onChanged: (newValue) {
                  allergyNames[index] = newValue.toString();
                },
                validator: (value) {
                  if ((value == null || value.isEmpty) &&
                      allergySeverities[index] == -1) {
                    remove.add(index);
                    return null;
                  }
                  return (value == null || value.isEmpty)
                      ? 'Enter Allergy or Delete'
                      : null;
                }),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: SizedBox(
              width: 88,
              child: DropdownButtonFormField(
                  hint: const Text('Severity'),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 8)),
                  value: (allergySeverities[index] != -1)
                      ? items[allergySeverities[index]]
                      : null,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (newValue) {
                    allergySeverities[index] =
                        items.indexOf(newValue.toString());
                  },
                  validator: (value) {
                    return (value != null || remove.contains(index))
                        ? null
                        : 'Select Severity';
                  }),
            ),
          ),
        ],
      ),
    );
  }

  static Widget allergies(List<String> allergyNames,
      List<int> allergySeverities, List<int> remove) {
    return StatefulBuilder(
      builder: (context, setState) {
        List<Widget> allergyFields =
            List.generate(allergyNames.length, (int index) {
          return _allergyField(
              index, allergyNames, allergySeverities, remove, setState);
        });

        allergyFields.add(ElevatedButton(
          child: const Text('Add another allergy'),
          onPressed: () {
            setState(() {
              allergyNames.add('');
              allergySeverities.add(-1);
            });
          },
        ));

        return Column(children: allergyFields);
      },
    );
  }

  static Widget pediatrician(TextEditingController pedController) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: TextFormField(
        autofocus: true,
        controller: pedController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter your pediatrician\'s name'
              : null;
        },
        decoration: const InputDecoration(
            icon: Icon(Icons.medical_services_outlined),
            labelText: 'Name of Pediatrician'),
      ),
    );
  }

  static Widget pediatricianPhone(TextEditingController pedPhoneController) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.phone,
        controller: pedPhoneController,
        validator: (value) {
          return (value == null || value.length != 12)
              ? 'Enter a valid phone number'
              : null;
        },
        decoration: const InputDecoration(
          icon: Icon(Icons.contacts_outlined),
          labelText: 'Pediatrician\'s Phone Number',
        ),
        inputFormatters: [
          LibPhonenumberTextFormatter(
            country: const CountryWithPhoneCode.us(),
            inputContainsCountryCode: false,
            additionalDigits: 0,
          ),
        ],
      ),
    );
  }

  static List<Widget> _getImage(TextEditingController imageController) {
    if (imageController.text.isEmpty) return [];

    File imageFile = File(imageController.text);
    if (imageFile.existsSync()) {
      return [Image.file(File(imageController.text))];
    }

    return [Image.network(imageController.text)];
  }

  static Future _pickImage(
      TextEditingController imageController, Function setState) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => imageController.text = pickedFile.path);
    }
  }

  static Widget profilePicture(TextEditingController imageController) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            ..._getImage(imageController),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => _pickImage(imageController, setState),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select profile picture',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
