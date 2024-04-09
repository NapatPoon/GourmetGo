import 'package:flutter/material.dart';
import 'package:gourmet_app/pages/favorite.dart';
import 'package:gourmet_app/pages/food_allergy_edit.dart';
import 'package:gourmet_app/pages/recommended.dart';
import 'package:gourmet_app/pages/result.dart';
import 'package:gourmet_app/pages/search.dart';
import 'package:gourmet_app/pages/search.dart';
import 'package:gourmet_app/pages/video.dart';
import '../components/bottom_nav.dart';
import 'food_allergy.dart';
import '../models/recipe.dart';
import '../services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();
  late User? user;
  List<FoodRecipe> recipes = [];

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Welcome, ${user?.displayName ?? 'Guest'}', // Changed greeting text
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          // Add IconButton for recommendation page
          IconButton(
            icon: Icon(
              Icons.local_dining,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to recommendation page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recommended()),
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'What are you cooking today?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Let's cook!",
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          try {
                            List<FoodRecipe> fetchedRecipes =
                                await apiService.searchFood(value);
                            setState(() {
                              recipes = fetchedRecipes;
                            });
                          } catch (e) {
                            // Handle error
                          }
                        } else {
                          setState(() {
                            recipes = [];
                          });
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.black),
                    onPressed: () async {},
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailsPage(recipe: recipes[index]),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                            recipes[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              recipes[index].image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.teal,
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              addToFavorites(recipes[index]);
                            },
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodAllergyEdit()),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}

void addToFavorites(FoodRecipe recipe) {
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  favorites.add({
    'title': recipe.title,
    'image': recipe.image,
  }).then((value) {
    print("Recipe added to favorites with ID: ${value.id}");
  }).catchError((error) {
    print("Failed to add recipe to favorites: $error");
  });
}
