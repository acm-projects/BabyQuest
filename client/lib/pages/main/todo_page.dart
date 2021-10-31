import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client/widgets/add_todo_dialog_widget.dart';
import 'package:client/widgets/todo_list_widget.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
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
          body: TabBarView(
            children: [
              TodoListWidget(),
              Container(),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AddTodoDialogWidget();
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add, color: Colors.black,),
            ),
          ),

        ),
    );
  }
}



