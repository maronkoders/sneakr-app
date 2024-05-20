import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

class Product {
  final String name;
  final double price;
  final int pairs;
  final DateTime date;

  Product(
      {required this.name,
      required this.price,
      required this.pairs,
      required this.date});
}

class sales extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Nikes', price: 120.0, pairs: 15, date: DateTime.now()),
    Product(name: 'Jordan ', price: 150.0, pairs: 20, date: DateTime.now()),
    Product(name: 'Formal male ', price: 180.0, pairs: 5, date: DateTime.now()),
    // Add more products as needed
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Sales'),
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
            label: Text('Price'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.price.compareTo(b.price)
                  : b.price.compareTo(a.price));
            },
          ),
          DataColumn(
            label: Text('Pairs'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.pairs.compareTo(b.pairs)
                  : b.pairs.compareTo(a.pairs));
            },
          ),
          DataColumn(
            label: Text('Date'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.date.compareTo(b.date)
                  : b.date.compareTo(a.date));
            },
          ),
        ],
        rows: products
            .map((product) => DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
                    DataCell(Text(product.pairs.toString())),
                    DataCell(
                        Text(DateFormat('yyyy-MM-dd').format(product.date))),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
