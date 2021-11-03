import 'package:flutter/material.dart';
import 'todo_form.dart';
import 'package:client/models/todo.dart';
import 'package:client/models/app_user.dart';

class EditTodoDialogWidget extends StatefulWidget {
  final Todo todo;
  final Function onDeleteTodo;

  const EditTodoDialogWidget({
    required this.todo,
    required this.onDeleteTodo,
    Key? key
  }) : super(key: key);

  @override
  _EditTodoDialogWidgetState createState() => _EditTodoDialogWidgetState();
}

class _EditTodoDialogWidgetState extends State<EditTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            TodoFormWidget(
              title: widget.todo.title,
              description: widget.todo.description,
              onChangedTitle: (title) => setState(() => widget.todo.setTitle = (title)),
              onChangedDescription: (description) =>
                  setState(() => widget.todo.setDescrip = description),
              onSavedTodo: editTodo,
            ),
            MaterialButton(
              onPressed: () {
                widget.onDeleteTodo(context, widget.todo);
                Navigator.of(context).pop();
              },
              shape: const StadiumBorder(),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete),
                  SizedBox(width: 5),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editTodo () {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      AppUser.currentUser!.updateTodo(widget.todo);

      Navigator.of(context).pop();
    }
  }
}
