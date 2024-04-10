import 'package:flutter/material.dart';

class AllergiesPage extends StatelessWidget {
  final List<String> allergies;

  AllergiesPage({required this.allergies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allergies'),
      ),
      body: allergies.isEmpty
          ? Center(
              child: Text(
                'No allergies found',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: allergies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        allergies[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
