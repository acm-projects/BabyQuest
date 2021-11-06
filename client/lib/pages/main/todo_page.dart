import 'package:client/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:client/widgets/add_todo_dialog_widget.dart';
import 'package:client/widgets/todo_list_widget.dart';
import 'package:client/widgets/completed_list_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: FaIcon(FontAwesomeIcons.listAlt),
                text: 'Todos',
              ),
              Tab(
                icon: FaIcon(FontAwesomeIcons.check),
                text: 'Completed',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TodoListWidget(),
            CompletedListWidget(),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () async {
                await showEditDialog(
                    context: context,
                    label: "Add Todo",
                    field: const AddTodoDialogWidget(),
                    updateData: () {},
                    formKey: _formKey);
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
