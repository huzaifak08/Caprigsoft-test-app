import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user to FireStore"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 12),
            TextField(
              controller: controllerName,
              decoration: InputDecoration(
                label: Text("Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: controllerAge,
              decoration: InputDecoration(
                label: Text("Age"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: controllerDate,
              decoration: InputDecoration(
                label: Text("Date Of Birth"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: () {
                final newUser = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(controllerDate.text));
                Navigator.pop(context);
                createUser(user: newUser);
              },
              child: Text("Add User"),
            ),
          ],
        ),
      ),
    );
  }
}

Future createUser({required User user}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  user.id = docUser.id;

  // final user = User(
  //     id: docUser.id, name: name, age: 21, birthday: DateTime(2001, 10, 12));
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
