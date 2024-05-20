import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class Product {
  final String name;
  final String surname;
  final String email;
  final String role;

  Product(
      {required this.name,
      required this.surname,
      required this.email,
      required this.role});
}

class usersScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
        name: 'Munya',
        surname: 'Munhu',
        email: 'munhu@gmail.com',
        role: 'Attendant'),
    Product(
        name: 'Romeo',
        surname: 'Musi',
        email: 'munhu@gmail.com',
        role: 'Administrator'),
    Product(
        name: 'Munya',
        surname: 'Munhu',
        email: 'munhu@gmail.com',
        role: 'Attendant'),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showDataEntryModal(context)),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Handle refresh product list
            },
          ),
        ],
      ),
      body: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: [
          DataColumn(
            label: Text('Name'),
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.name.compareTo(b.name)
                  : b.name.compareTo(a.name));
            },
          ),
          DataColumn(
            label: Text('Surname'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.surname.compareTo(b.surname)
                  : b.surname.compareTo(a.surname));
            },
          ),
          DataColumn(
            label: Text('Email'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.surname.compareTo(b.surname)
                  : b.surname.compareTo(a.surname));
            },
          ),
          DataColumn(
            label: Text('Role'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.role.compareTo(b.role)
                  : b.role.compareTo(a.role));
            },
          ),
        ],
        rows: products
            .map((product) => DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.surname)),
                    DataCell(Text(product.email)),
                    DataCell(Text(product.role)),
                  ],
                ))
            .toList(),
      ),
    );
  }

//New Product
  void _showDataEntryModal(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
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
                items:
                    <String>['Attendant', 'Administrator'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextFormField(
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
