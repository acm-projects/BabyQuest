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
        autofocus: true,
        controller: nameController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter the baby\'s full name'
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
        return GestureDetector(
          child: SizedBox(
            width: 256,
            child: TextFormField(
              controller: viewController,
              enabled: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.calendar_today),
              ),
            ),
          ),
          onTap: () async {
            await _selectDate(birthDateController, context);
            setState(() =>
                viewController.text = _getFormattedDate(birthDateController));
          },
        );
      },
    );
  }

  static Widget gender(TextEditingController genderController) {
    var items = ['Select Gender', 'Male', 'Female', 'Other'];

    if (genderController.text.isEmpty) {
      genderController.text = '-1';
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            Icon(
              BabyProfile.getGenderIcon(
                int.parse(genderController.text),
              ),
              color: const Color(0xFF8C8161),
              size: 17,
            ),
            const SizedBox(
              width: 16,
            ),
            DropdownButton(
              hint: const Text('Select Gender'),
              isDense: true,
              underline: Container(),
              style: Theme.of(context).textTheme.subtitle1,
              autofocus: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF8C8161),
              ),
              value: items[int.parse(genderController.text) + 1],
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (newValue) {
                setState(() => genderController.text =
                    (items.indexOf(newValue.toString()) - 1).toString());
              },
            ),
          ],
        );
      },
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
              labelText: 'Height',
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
              hintText: '19',
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
      List<int> allergySeverities, Function setState) {
    var items = ['Select', 'Mild', 'Moderate', 'Severe'];

    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            initialValue: allergyNames[index],
            decoration: const InputDecoration(
                labelText: 'Allergy',
                isDense: true,
                contentPadding: EdgeInsets.zero),
            onChanged: (newValue) {
              allergyNames[index] = newValue.toString();
            },
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
          underline: Container(),
          value: items[allergySeverities[index] + 1],
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (newValue) {
            setState(() => allergySeverities[index] =
                items.indexOf(newValue.toString()) - 1);
          },
        ),
      ],
    );
  }

  static Widget allergies(
      List<String> allergyNames, List<int> allergySeverities) {
    return StatefulBuilder(
      builder: (context, setState) {
        List<Widget> allergyFields =
            List.generate(allergyNames.length, (int index) {
          return _allergyField(
              index, allergyNames, allergySeverities, setState);
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

  static List<Widget> _getLocalImage(TextEditingController imageController) {
    return imageController.text.isNotEmpty
        ? [Image.file(File(imageController.text))]
        : [];
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
            ..._getLocalImage(imageController),
            ElevatedButton(
              onPressed: () => _pickImage(imageController, setState),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select profile picture',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        );
      },
    );
  }
}
