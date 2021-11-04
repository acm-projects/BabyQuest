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
    return StreamBuilder(
      stream: AppUser.updateStream,
      builder: (context, snapshot) {
        List<Todo> todos = AppUser.currentUser?.todosCompleted ?? [];
        return todos.isEmpty
            ? const Center(
          child: Text(
            'No completed tasks',
            style: TextStyle(fontSize: 20),
          ),
        )
            : ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
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
