import 'package:flutter/material.dart';
import 'package:gourmet_app/pages/favorite.dart';
import 'package:gourmet_app/pages/food_allergy_edit.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/result.dart';
import '../components/bottom_nav.dart';
import 'food_allergy.dart';
import '../models/recipe.dart';
import '../services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ApiService apiService = ApiService();
  late User? user;
  List<FoodRecipe> recipes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Search Recipe',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            TextField(
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
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to details page when recipe is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailsPage(recipe: recipes[index]),
                        ),
                      );
                    },
                    child: Container(
                      height: 120, // Adjusted height of container
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                recipes[index].image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey,
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    recipes[index].title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // You can add more recipe details here
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
              break;
            case 1:
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
                MaterialPageRoute(builder: (context) => FoodAllergyEdit()),
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
