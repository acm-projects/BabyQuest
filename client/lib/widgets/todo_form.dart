import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 32),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
      ),
      onChanged: onChangedTitle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'title cannot be empty';
        }
        return null;
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
      ),
      onChanged: onChangedDescription,
    );
  }

  Widget buildButton() {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: onSavedTodo,
        shape: const StadiumBorder(),
        color: Colors.deepPurple.shade300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.save_alt_rounded),
            SizedBox(width: 5),
            Text('Save Task'),
          ],
        ),
      ),
    );
  }
}
