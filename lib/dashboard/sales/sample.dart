import 'package:flutter/material.dart';

class AutoCompleteAddListWidget extends StatefulWidget {
  @override
  _AutoCompleteAddListWidgetState createState() =>
      _AutoCompleteAddListWidgetState();
}

class _AutoCompleteAddListWidgetState extends State<AutoCompleteAddListWidget> {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry'
  ];
  List<String> selectedItems = [];
  String searchText = '';

  void addItemToList(String item) {
    setState(() {
      selectedItems.add(item);
      searchText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (searchText.isNotEmpty &&
                    !selectedItems.contains(searchText)) {
                  addItemToList(searchText);
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: selectedItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(selectedItems[index]),
              subtitle: Text('Additional Info'),
            );
          },
        ),
      ],
    );
  }
}
