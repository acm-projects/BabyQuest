import 'package:flutter/material.dart';

class TodoList {
  List<Todo> allTodos = [];

  List<Todo> get listTodos {
    return allTodos;
  }

  Map<int, List<dynamic>> get toMap {
    Map<int, List<dynamic>> todoMap = {};
    for (int idx = 0; idx < allTodos.length; idx += 1) {
      Todo current = allTodos[idx];
      List<dynamic> fields = [current.title, current.description, current.id, current.time, current.isDone];
      todoMap[idx] = fields;
    }

    return todoMap;
  }
}

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
}