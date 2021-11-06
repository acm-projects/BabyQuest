import 'package:client/models/app_user.dart';
import 'package:client/models/todo.dart';
import 'package:client/widgets/dotted_divider.dart';
import 'package:client/widgets/edit_dialog.dart';
import 'package:client/widgets/todo_widget.dart';
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
    return Scaffold(
      body: StreamBuilder(
        stream: AppUser.updateStream,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Color(0x15FFFFFF), BlendMode.dstATop),
                    image: AssetImage('assets/images/undraw_mother.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),
                    RichText(
                      text: TextSpan(
                          text: 'To Do',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    const DottedDivider(),
                    const TodoListWidget(),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                          text: 'Completed',
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    const DottedDivider(),
                    const CompletedListWidget(),
                    const SizedBox(height: 128),
                  ],
                ),
              ),
            ),
          );
        },
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
    );
  }
}
