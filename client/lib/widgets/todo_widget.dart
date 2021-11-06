import 'package:client/widgets/edit_dialog.dart';
import 'package:client/widgets/todo_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:client/models/todo.dart';
import 'package:client/models/app_user.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final _formKey = GlobalKey<FormState>();

  TodoWidget({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(todo.id),
        actions: [
          IconSlideAction(
            onTap: () async {
                final title = TextEditingController(text: todo.title);
                final description = TextEditingController(text: todo.description);

                await showEditDialog(
                    context: context,
                    label: "Edit Todo",
                    field: TodoFormWidget(title, description),
                    updateData: () {
                      todo.title = title.text;
                      todo.description = description.text;

                      AppUser.currentUser?.updateTodo(todo);
                    },
                    formKey: _formKey);
              },
            color: Colors.green,
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            onTap: () => deleteTodo(context, todo),
            color: Colors.red,
            caption: 'Delete',
            icon: Icons.delete,
          )
        ],
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            activeColor: Theme.of(context).colorScheme.primary,
            checkColor: Colors.white,
            value: todo.isDone,
            onChanged: (_) {
              final isDone = AppUser.currentUser!.toggleTodoStatus(todo);

              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(milliseconds: 2000),
                    content: Text(isDone ? 'Task Completed' : 'Task marked imcomplete'),
                  )
              );
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    AppUser.currentUser!.removeTodo(todo);

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          padding: EdgeInsets.symmetric(horizontal: 16),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 2000),
          content: Text('Deleted the task'),
        )
    );
  }
}

