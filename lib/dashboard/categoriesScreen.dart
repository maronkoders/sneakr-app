import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final int stock;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock});
}

class categoriesScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '001', name: 'Formal Shoes ', price: 120.0, stock: 15),
    Product(id: '002', name: 'Slides ', price: 150.0, stock: 20),
    Product(id: '003', name: 'Sneakers ', price: 180.0, stock: 5),
    // Add more products as needed
  ];

  //New Category
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
        title: Text('Sneaker Categories'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showDataEntryModal(context);
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
          DataColumn(
            label: Text('Name'),
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.name.compareTo(b.name)
                  : b.name.compareTo(a.name));
            },
          ),
          DataColumn(
            label: Text('Stock'),
            numeric: true,
            onSort: (columnIndex, ascending) {
              products.sort((a, b) => ascending
                  ? a.stock.compareTo(b.stock)
                  : b.stock.compareTo(a.stock));
            },
          ),
        ],
        rows: products
            .map((product) => DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.stock.toString())),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
