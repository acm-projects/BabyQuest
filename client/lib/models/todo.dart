import 'package:flutter/material.dart';

/*class TodoList {

}*/

class Todo {
  String title;
  String id;
  String description;
  DateTime createdTime;
  bool isDone;
  bool removed;

  Todo({
    required this.title,
    this.description = '',
    this.id = '',
    required this.createdTime,
    this.isDone = false,
    this.removed = false,
  });

  String get time => createdTime.toString();

  //setter methods
  set setTitle(String newTitle) {
    title = newTitle;
  }
  set setDescrip(String newDescription) {
    description = newDescription;
  }
  void toggleDone() {
    isDone = !isDone;
  }
  void removing() {
    removed = !removed;
  }

  //returns all object fields - passed to map key
  List<dynamic> fields() {
    List<dynamic> fields = [title, description, id, time, isDone, removed];
    return fields;
  }
}