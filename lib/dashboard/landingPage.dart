import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class DashboardPage extends StatelessWidget {
  int getTotalStock() {
    return sneakers.fold(0, (total, sneaker) => total + sneaker.stock);
  }

  // Calculate average price
  double getAveragePrice() {
    if (sneakers.isEmpty) return 0.0;
    return sneakers.fold(0.0, (total, sneaker) => total + sneaker.price) /
        sneakers.length;
  }

  @override
  Widget build(BuildContext context) {
    int totalStock = getTotalStock();
    double averagePrice = getAveragePrice();
    int totalModels = sneakers.length;
    return Scaffold(
      appBar: AppBar(title: Text('Sneaker Stock Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Kays Fashions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.shelves),
              title: Text('Products'),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Categories'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(context, '/categories');
                    // Navigate to security settings
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('All Sneakers'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushNamed(context, '/products');
                    // Navigate to display settings
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Sales'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/sales');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/settings'); // Navigate to Home
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Total Stock'),
                trailing: Text('$totalStock units'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Average Price'),
                trailing: Text('\$${averagePrice.toStringAsFixed(2)}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Monthly Sales'),
                trailing: Text('\$${averagePrice.toStringAsFixed(2)}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Today Sales'),
                trailing: Text('\$${averagePrice.toStringAsFixed(2)}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Out of stock'),
                trailing: Text('$totalModels categories'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
