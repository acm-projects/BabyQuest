import 'package:flutter/material.dart';

/*class TodoList {

}*/

class Todo {
  String title;
  String id;
  String description;
  DateTime createdTime;
  bool isDone;

  Todo({
    required this.title,
    this.description = '',
    this.id = '',
    required this.createdTime,
    this.isDone = false,
  });

  String get time => createdTime.toString();

  List<dynamic> fields() {
    List<dynamic> fields = [title, description, id, time, isDone];
    return fields;
  }

  /*Map<int, List<dynamic>> get toMap {
    Map<int, List<dynamic>> todoMap = {};
    for (int idx = 0; idx < allTodos.length; idx += 1) {
      Todo current = allTodos[idx];
      List<dynamic> fields = [current.title, current.description, current.id, current.time, current.isDone];
      todoMap[idx] = fields;
    }

    return todoMap;
  }*/
}