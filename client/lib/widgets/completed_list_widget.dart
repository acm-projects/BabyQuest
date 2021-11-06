import 'package:flutter/material.dart';

import 'package:client/models/todo.dart';
import 'package:client/widgets/todo_widget.dart';
import 'package:client/models/app_user.dart';

class CompletedListWidget extends StatefulWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  _CompletedListWidgetState createState() => _CompletedListWidgetState();
}

class _CompletedListWidgetState extends State<CompletedListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Todo> completed = AppUser.currentUser?.todosCompleted ?? [];
    return completed.isEmpty
        ? const Center(
            child: Text(
              'No completed tasks',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: completed.length,
            itemBuilder: (context, index) {
              final todo = completed[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}
