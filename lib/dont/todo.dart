import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editTaskController = TextEditingController();

  String _sortOrder = 'Ajout';

  void _addTodoItem(String name, int task) {
    setState(() {
      _todoItems
          .add(TodoItem(name: name, task: task, dateAdded: DateTime.now()));
      _sortTodoItems();
    });
    _nameController.clear();
    _taskController.clear();
  }

  void _editTodoItem(TodoItem item, String newName, int newTask) {
    setState(() {
      item.name = newName;
      item.task = newTask;
      _sortTodoItems();
    });
  }

  void _removeTodoItem(TodoItem item) {
    setState(() {
      _todoItems.remove(item);
    });
  }

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
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(labelText: 'Nombre de tâches'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[^0-9]')),
                ],
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
                if (_nameController.text.isNotEmpty &&
                    _taskController.text.isNotEmpty) {
                  _addTodoItem(
                      _nameController.text, int.parse(_taskController.text));
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
    _editNameController.text = item.name;
    _editTaskController.text = item.task.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier tâche'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _editTaskController,
                decoration: InputDecoration(labelText: 'Nombre de tâches'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny(RegExp(r'[^0-9]')),
                ],
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
                if (_editNameController.text.isNotEmpty &&
                    _editTaskController.text.isNotEmpty) {
                  _editTodoItem(item, _editNameController.text,
                      int.parse(_editTaskController.text));
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

  void _sortTodoItems() {
    if (_sortOrder == 'Ajout') {
      _todoItems.sort((a, b) => a.dateAdded.compareTo(b.dateAdded));
    } else if (_sortOrder == 'Alphabetique') {
      _todoItems.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  Widget _buildTodoItem(TodoItem item) {
    return Dismissible(
      key: Key(item.name + item.task.toString()),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        _removeTodoItem(item);
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
            value: _sortOrder,
            icon: Icon(Icons.sort),
            onChanged: (String? newValue) {
              setState(() {
                _sortOrder = newValue!;
                _sortTodoItems();
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
        children: _todoItems.map((item) => _buildTodoItem(item)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Ajouter une tâche',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  String name;
  int task;
  DateTime dateAdded;

  TodoItem({required this.name, required this.task, required this.dateAdded});
}
