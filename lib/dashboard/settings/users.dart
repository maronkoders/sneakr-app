import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'dart:async';
import '/models/database_helper.dart';

class User {
  final String name;
  final String surname;
  final String email;
  final String role;
  final String password;
  final String confirmPassword;

  User(
      {required this.name,
      required this.surname,
      required this.email,
      required this.role,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'role': role,
      'password': password,
    };
  }
}

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final dbHelper = DatabaseHelper();
    final userMaps = await dbHelper.queryAllUsers();
    setState(() {
      users = userMaps
          .map((map) => User(
                name: map['name'],
                surname: map['surname'],
                email: map['email'],
                role: map['role'],
                password: map['password'],
                confirmPassword: map['confirmPassword'],
              ))
          .toList();
    });
  }

  void _addUser(User user) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertUser(user.toMap());
    _fetchUsers(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showDataEntryModal(context),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchUsers,
          ),
        ],
      ),
      body: DataTable2(
        columnSpacing: 10,
        horizontalMargin: 12,
        minWidth: 500,
        columns: [
          DataColumn(
            label: Text('Name'),
            onSort: (columnIndex, ascending) {
              setState(() {
                users.sort((a, b) => ascending
                    ? a.name.compareTo(b.name)
                    : b.name.compareTo(a.name));
              });
            },
          ),
          DataColumn(
            label: Text('Surname'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              setState(() {
                users.sort((a, b) => ascending
                    ? a.surname.compareTo(b.surname)
                    : b.surname.compareTo(a.surname));
              });
            },
          ),
          DataColumn(
            label: Text('Email'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              setState(() {
                users.sort((a, b) => ascending
                    ? a.email.compareTo(b.email)
                    : b.email.compareTo(a.email));
              });
            },
          ),
          DataColumn(
            label: Text('Role'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              setState(() {
                users.sort((a, b) => ascending
                    ? a.role.compareTo(b.role)
                    : b.role.compareTo(a.role));
              });
            },
          ),
        ],
        rows: users
            .map((user) => DataRow(
                  cells: [
                    DataCell(Text(user.name)),
                    DataCell(Text(user.surname)),
                    DataCell(Text(user.email)),
                    DataCell(Text(user.role)),
                  ],
                ))
            .toList(),
      ),
    );
  }

  void _showDataEntryModal(BuildContext context) {
    final nameController = TextEditingController();
    final surnameController = TextEditingController();
    final emailController = TextEditingController();
    final roleController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      barrierColor: Colors.black45,
      isDismissible: false,
      enableDrag: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: surnameController,
                  decoration: InputDecoration(
                    labelText: 'Surname',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Role',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Attendant', 'Administrator']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    roleController.text = newValue!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      final newUser = User(
                        name: nameController.text,
                        surname: surnameController.text,
                        email: emailController.text,
                        role: roleController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                      _addUser(newUser);
                      Navigator.pop(context);
                    } else {
                      // Handle password mismatch
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
