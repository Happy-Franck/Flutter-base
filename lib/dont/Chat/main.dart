import 'package:flutter/material.dart';
import 'chat_screen.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Alice',
      'avatarUrl': 'https://via.placeholder.com/150',
      'stars': 5
    },
    {'name': 'Bob', 'avatarUrl': 'https://via.placeholder.com/150', 'stars': 3},
    {
      'name': 'Charlie',
      'avatarUrl': 'https://via.placeholder.com/150',
      'stars': 4
    },
  ];

  List<Map<String, dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = _users;
    _searchController.addListener(() {
      _filterUsers();
    });
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        final name = user['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(user['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user['avatarUrl']),
                radius: 40,
              ),
              SizedBox(height: 16),
              Text('Nombre d\'étoiles : ${user['stars']}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Message'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(userName: user['name']),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final user = _filteredUsers[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatarUrl']),
                    ),
                    title: Text(user['name']),
                    subtitle: Row(
                      children: List.generate(user['stars'], (index) {
                        return Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        );
                      }),
                    ),
                    onTap: () => _showUserDetails(user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
