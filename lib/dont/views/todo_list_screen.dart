// lib/views/todo_list_screen.dart

import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_item.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoController _controller = TodoController();

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nouvelle tâche'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller.nameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _controller.taskController,
                decoration: InputDecoration(labelText: 'Nombre de tâches'),
                keyboardType: TextInputType.number,
                inputFormatters: [_controller.numberInputFormatter],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (_controller.nameController.text.isNotEmpty &&
                    _controller.taskController.text.isNotEmpty) {
                  _controller.addTodoItem(
                    _controller.nameController.text,
                    int.parse(_controller.taskController.text),
                    () => setState(() {}),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _promptEditTodoItem(TodoItem item) {
    _controller.editNameController.text = item.name;
    _controller.editTaskController.text = item.task.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier tâche'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller.editNameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _controller.editTaskController,
                decoration: InputDecoration(labelText: 'Nombre de tâches'),
                keyboardType: TextInputType.number,
                inputFormatters: [_controller.numberInputFormatter],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (_controller.editNameController.text.isNotEmpty &&
                    _controller.editTaskController.text.isNotEmpty) {
                  _controller.editTodoItem(
                    item,
                    _controller.editNameController.text,
                    int.parse(_controller.editTaskController.text),
                    () => setState(() {}),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoItem(TodoItem item) {
    return Dismissible(
      key: Key(item.name + item.task.toString()),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        _controller.removeTodoItem(item, () => setState(() {}));
      },
      child: ListTile(
        title: Text('${item.name} - ${item.task} tâches'),
        subtitle: Text('Ajouté le ${item.dateAdded.toString()}'),
        onTap: () {
          _promptEditTodoItem(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: <Widget>[
          DropdownButton<String>(
            value: _controller.sortOrder,
            icon: Icon(Icons.sort),
            onChanged: (String? newValue) {
              setState(() {
                _controller.sortOrder = newValue!;
                _controller.sortTodoItems();
              });
            },
            items: <String>['Ajout', 'Alphabetique']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: ListView(
        children:
            _controller.todoItems.map((item) => _buildTodoItem(item)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Ajouter une tâche',
        child: Icon(Icons.add),
      ),
    );
  }
}
