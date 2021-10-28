import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class UserInputWidgets {
  static List<Widget> name(TextEditingController firstNameController,
      TextEditingController lastNameController) {
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'First Name'),
        controller: firstNameController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter the first name'
              : null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Last Name'),
        controller: lastNameController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter the last name'
              : null;
        },
      ),
    ];
  }

  static List<Widget> birthDate(BuildContext context, Function setState,
      TextEditingController birthDateController) {
    _selectDate(BuildContext context, Function setState) async {
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

    String selectedDate;

    if (birthDateController.text.isNotEmpty) {
      DateTime unformattedDate = DateTime.parse(birthDateController.text);
      selectedDate = '${unformattedDate.day}/${unformattedDate.month}/${unformattedDate.year}';
    } else {
      selectedDate = 'Select';
    }

    return [
      Row(
        children: [
          const Text('Date of Birth:'),
          const SizedBox(width: 50),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _selectDate(context, setState), // Refer step 3
              child: Text(
                selectedDate,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
              ),
            ),
          ),
        ],
      ),
    ];
  }

  static List<Widget> height(TextEditingController heightController) {
    return [
      Row(
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
      ),
    ];
  }

  static List<Widget> weight(TextEditingController weightLbController,
      TextEditingController weightOzController) {
    return [
      Row(
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
      ),
    ];
  }

  static List<Widget> pediatrician(TextEditingController pedController) {
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Name of Pediatrician'),
        controller: pedController,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? 'Enter your pediatrician\'s name'
              : null;
        },
      ),
    ];
  }

  static List<Widget> pediatricianPhone(
      TextEditingController pedPhoneController) {
    return [
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
    ];
  }
}
