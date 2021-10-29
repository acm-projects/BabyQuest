import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidgets {
  static Widget name(TextEditingController nameController) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Full Name'),
      controller: nameController,
      validator: (value) {
        return (value == null || value.isEmpty) ? 'Enter the full name' : null;
      },
    );
  }

  static _selectDate(TextEditingController birthDateController,
      BuildContext context, Function setState) async {
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
      setState(() => birthDateController.text = selectedDate.toString());
    }
  }

  static String _getFormattedDate(TextEditingController birthDateController) {
    if (birthDateController.text.isNotEmpty) {
      DateTime unformattedDate = DateTime.parse(birthDateController.text);
      return '${unformattedDate.day}/${unformattedDate.month}/${unformattedDate.year}';
    }

    return 'Select';
  }

  static Widget birthDate(BuildContext context, Function setState,
      TextEditingController birthDateController) {
    return Row(
      children: [
        const Text('Date of Birth:'),
        const SizedBox(width: 50),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _selectDate(
                birthDateController, context, setState), // Refer step 3
            child: Text(
              _getFormattedDate(birthDateController),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
            ),
          ),
        ),
      ],
    );
  }

  static Widget gender(
      TextEditingController genderController, Function setState) {
    var items = ['Select', 'Male', 'Female', 'Other'];

    if (genderController.text.isEmpty) {
      genderController.text = '-1';
    }

    return Row(
      children: [
        const Text('Select Gender of child:'),
        const SizedBox(width: 50),
        Expanded(
          child: DropdownButton(
            value: items[int.parse(genderController.text) + 1],
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (newValue) {
              setState(() => genderController.text =
                  (items.indexOf(newValue.toString()) - 1).toString());
            },
          ),
        ),
      ],
    );
  }

  static Widget height(TextEditingController heightController) {
    return Row(
      children: [
        const Text('Height'),
        const SizedBox(width: 50),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Inches'),
            keyboardType: TextInputType.number,
            controller: heightController,
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Enter the height (in)'
                  : null;
            },
          ),
        ),
      ],
    );
  }

  static Widget weight(TextEditingController weightLbController,
      TextEditingController weightOzController) {
    return Row(
      children: [
        const Text(
          'Weight',
        ),
        const SizedBox(width: 50),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Pounds'),
            keyboardType: TextInputType.number,
            controller: weightLbController,
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
            controller: weightOzController,
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Enter the weight (oz)'
                  : null;
            },
          ),
        ),
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
            decoration: const InputDecoration(labelText: 'Allergies'),
            onChanged: (newValue) {
              allergyNames[index] = newValue.toString();
            },
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
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

  static Widget allergies(List<String> allergyNames,
      List<int> allergySeverities, Function setState) {
    List<Widget> allergyFields =
        List.generate(allergyNames.length, (int index) {
      return _allergyField(index, allergyNames, allergySeverities, setState);
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
  }

  static Widget pediatrician(TextEditingController pedController) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name of Pediatrician'),
      controller: pedController,
      validator: (value) {
        return (value == null || value.isEmpty)
            ? 'Enter your pediatrician\'s name'
            : null;
      },
    );
  }

  static Widget pediatricianPhone(TextEditingController pedPhoneController) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Pediatrician Contact Information',
            suffixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          controller: pedPhoneController,
          validator: (value) {
            return (value == null || value.length != 12)
                ? 'Enter a valid phone number'
                : null;
          },
          inputFormatters: [
            LibPhonenumberTextFormatter(
              country: const CountryWithPhoneCode.us(),
              inputContainsCountryCode: false,
              additionalDigits: 0,
            ),
          ],
        ),
      ],
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

  static Widget profilePicture(
      TextEditingController imageController, Function setState) {
    return Column(
      children: [
        ..._getLocalImage(imageController),
        ElevatedButton(
          onPressed: () => _pickImage(imageController, setState),
          child: const Text(
            'Select profile picture',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlueAccent,
          ),
        ),
      ],
    );
  }
}
