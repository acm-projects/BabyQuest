import 'package:flutter/material.dart';

import 'package:client/models/todo.dart';
import 'package:client/widgets/todo_widget.dart';
import 'package:client/models/app_user.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AppUser.updateStream,
      builder: (context, snapshot) {
        List<Todo> todos = AppUser.currentUser?.todosInProgress ?? [];
        return todos.isEmpty
            ? const Center(
                child: Text(
                  'No todos',
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.separated(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Container(height: 8),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return TodoWidget(todo: todo);
                },
              );
      },
    );
  }
}
