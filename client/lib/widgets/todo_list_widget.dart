import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/todo.dart';
import 'package:client/widgets/todo_widget.dart';
import 'package:client/services/data_service.dart';
import 'package:client/models/app_user.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  AppUser? _currentUser = AppUser.currentUser;

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = _currentUser!.toDoList;

    return todos.isEmpty
      ? Center(
          child: Text(
            'No todos',
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
  }
}

