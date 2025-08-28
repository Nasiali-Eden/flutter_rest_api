import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Integration Demo')),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: NetworkImage(user.thumbnail),
                ),
              ],
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
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
    final results = json['results'] as List<dynamic>;

    final transformed = results.map((e) => User.fromJson(e)).toList();

    setState(() {
      users = transformed;
    });

    if (kDebugMode) {
      print("Complete fetch users");
    }
  }
}
