import 'package:flutter/material.dart';
import 'package:gourmet_app/components/bottom_nav.dart';
import 'package:gourmet_app/models/recipe_vid.dart';
import 'package:gourmet_app/pages/allergy_list.dart';
import 'package:gourmet_app/pages/favorite.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/login.dart';
import 'package:gourmet_app/pages/search.dart';
import 'package:gourmet_app/pages/favorite.dart';
import 'package:gourmet_app/pages/food_allergy.dart';
import 'package:gourmet_app/components/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gourmet_app/pages/video.dart';

class FoodAllergyEdit extends StatefulWidget {
  const FoodAllergyEdit({Key? key}) : super(key: key);

  @override
  _FoodAllergyEditState createState() => _FoodAllergyEditState();
}

class _FoodAllergyEditState extends State<FoodAllergyEdit> {
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
      appBar: AppBar(
        title: Text(
          'Food Allergy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Add more ingredients',
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
              child: Text('Add More Ingredient'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<String> allergies = await _getAllergies();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllergiesPage(allergies: allergies)),
                );
              },
              child: Text('View Allergic Ingredients'),
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
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeVideoPage()),
              );
              break;
            case 4:
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  Future<List<String>> _getAllergies() async {
    CollectionReference allergiesRef =
        FirebaseFirestore.instance.collection('allergies');
    QuerySnapshot querySnapshot = await allergiesRef.get();
    List<String> allergies = [];
    querySnapshot.docs.forEach((doc) {
      allergies.add(doc['allergy']);
    });
    return allergies;
  }

  Future<void> _saveAllergy(String allergy) async {
    CollectionReference allergies =
        FirebaseFirestore.instance.collection('allergies');
    await allergies.add({'allergy': allergy}).then((value) {
      print("Ingredients added with ID: ${value.id}");
      setState(() {
        _ingredients.add(allergy);
      });
    }).catchError((error) {
      print("Failed to add $error");
    });
  }
}
