import 'package:flutter/material.dart';
import 'todo_form.dart';
import 'package:client/models/todo.dart';
import 'package:client/models/app_user.dart';

class AddTodoDialogWidget extends StatefulWidget {
  String title;
  String descrip;
  bool editing;
  String currentId;

  AddTodoDialogWidget({
    this.title = '',
    this.descrip = '',
    this.editing = false,
    this.currentId = '',
    Key? key
  }) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
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
              'Add Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            TodoFormWidget(
              onChangedTitle: (title) => setState(() => widget.title = title),
              onChangedDescription: (description) =>
                  setState(() => widget.descrip = description),
              onSavedTodo: addTodo,
            ),
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final todo;
      if (widget.editing) {

      } else {
        todo = Todo(
          id: DateTime.now().toString(),
          title: widget.title,
          description: widget.descrip,
          createdTime: DateTime.now(),
        );
        AppUser.currentUser!.addTodo(todo);
      }



      Navigator.of(context).pop();
    }
  }
}
