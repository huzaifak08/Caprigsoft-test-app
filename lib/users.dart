import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: controller),
        actions: [
          IconButton(
            onPressed: () {
              final name = controller.text;

              createUser(name: name);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

Future createUser({required String name}) async {
  final docUser = FirebaseFirestore.instance.collection('user').doc();

  final user = User(
      id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 10, 12));
  final json = user.toJson();

  await docUser.set(json);
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User(
      {this.id = '',
      required this.name,
      required this.age,
      required this.birthday});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'age': age, 'birthday': birthday};
}
