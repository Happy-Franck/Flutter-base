// lib/controllers/todo_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/todo_item.dart';

class TodoController {
  final List<TodoItem> todoItems = [
    TodoItem(
        name: 'Acheter du pain',
        task: 2,
        dateAdded: DateTime.now().subtract(Duration(days: 3))),
    TodoItem(
        name: 'Faire du sport',
        task: 1,
        dateAdded: DateTime.now().subtract(Duration(days: 2))),
    TodoItem(
        name: 'Lire un livre',
        task: 0,
        dateAdded: DateTime.now().subtract(Duration(days: 1))),
  ];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editTaskController = TextEditingController();

  String sortOrder = 'Ajout';

  TodoController() {
    // Initialiser les données par défaut
    todoItems.addAll([
      TodoItem(
          name: 'Acheter du pain',
          task: 2,
          dateAdded: DateTime.now().subtract(Duration(days: 2))),
      TodoItem(
          name: 'Faire du sport',
          task: 1,
          dateAdded: DateTime.now().subtract(Duration(days: 1))),
      TodoItem(name: 'Lire un livre', task: 0, dateAdded: DateTime.now()),
    ]);
    sortTodoItems();
  }

  void addTodoItem(String name, int task, VoidCallback onUpdate) {
    todoItems.add(TodoItem(name: name, task: task, dateAdded: DateTime.now()));
    sortTodoItems();
    onUpdate();
  }

  void editTodoItem(
      TodoItem item, String newName, int newTask, VoidCallback onUpdate) {
    item.name = newName;
    item.task = newTask;
    sortTodoItems();
    onUpdate();
  }

  void removeTodoItem(TodoItem item, VoidCallback onUpdate) {
    todoItems.remove(item);
    onUpdate();
  }

  void sortTodoItems() {
    if (sortOrder == 'Ajout') {
      todoItems.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
    } else if (sortOrder == 'Alphabetique') {
      todoItems.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  TextInputFormatter get numberInputFormatter {
    return FilteringTextInputFormatter.digitsOnly;
  }
}
