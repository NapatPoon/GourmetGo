import 'package:flutter/material.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodAllergy extends StatefulWidget {
  const FoodAllergy({Key? key}) : super(key: key);

  @override
  _FoodAllergyState createState() => _FoodAllergyState();
}

class _FoodAllergyState extends State<FoodAllergy> {
  final TextEditingController _ingredientController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? user;

  List<String> _ingredients = [];

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'What are your food allergies? ${user?.displayName ?? 'Guest'}',
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
              controller: _ingredientController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter Ingredients',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String ingredient = _ingredientController.text.trim();
                  if (ingredient.isNotEmpty) {
                    _saveAllergy(ingredient);
                    _ingredients.add(ingredient);
                    _ingredientController.clear();
                  }
                });
              },
              child: Text('Add Ingredient'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(_ingredients[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAllergy(String allergy) async {
    CollectionReference allergies =
        FirebaseFirestore.instance.collection('allergies');
    allergies.add({
      'allergy': allergy,
    }).then((value) {
      print("Ingredients added with ID: ${value.id}");
    }).catchError((error) {
      print("Failed to add $error");
    });
  }
}
