import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final int pairs;
  final DateTime date;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.pairs,
      required this.date});
}

class sales extends StatelessWidget {
  final List<Product> products = [
    Product(
        id: '001',
        name: 'Nikes',
        price: 120.0,
        pairs: 15,
        date: DateTime.now()),
    Product(
        id: '002',
        name: 'Jordan ',
        price: 150.0,
        pairs: 20,
        date: DateTime.now()),
    Product(
        id: '003',
        name: 'Formal male ',
        price: 180.0,
        pairs: 5,
        date: DateTime.now()),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Sales'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle add new product
            },
          ),
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
          DataColumn2(
            label: Text('ID'),
            size: ColumnSize.L,
          ),
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
            label: Text('Stock'),
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
                    DataCell(Text(product.id)),
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
