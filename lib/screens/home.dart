import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Integration Demo')),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user['name'];
          final picture = user['picture'];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(picture['thumbnail']),
            ),
            title: Text('${name['first']} ${name['last']}'),
            subtitle: Text(user['email']),
          );
        },
      ),

    );
  }

  void fetchUsers() async {
    if (kDebugMode) {
      print('Fetch Users clicked');
    }

    const url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;

    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    if (kDebugMode) {
      print("Complete fetch users");
    }
  }
}
