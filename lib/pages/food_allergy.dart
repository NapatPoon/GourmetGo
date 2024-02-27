// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/login.dart';

class FoodAllergy extends StatelessWidget {
  const FoodAllergy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'What are your food allergies?',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 30,
                 fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text('Food Allergies',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter Ingredients',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
              // ignore: sort_child_properties_last
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Text color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              // ignore: sort_child_properties_last
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
