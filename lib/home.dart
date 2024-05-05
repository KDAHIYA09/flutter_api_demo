import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchUsers();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Expanded(
          child: Container(
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final email = user['email'];
                  final name = user['name']['first'];
                  final imageUrl = user['picture']['thumbnail'];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(name),
                    subtitle: Text(email),
                    trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(imageUrl)),
                  );
                },
              )),
        ),
      ),

    );
  }

  void fetchUsers() async {
    print('fetch users btn pressed');
    final url = 'https://randomuser.me/api/?results=500';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });

    print('users data fetched completed');
  }

}