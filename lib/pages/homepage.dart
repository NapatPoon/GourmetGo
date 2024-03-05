// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../components/bottom_nav.dart';
import 'food_allergy.dart';
import '../models/recipe.dart';
import '../services/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();
  List<FoodRecipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Hello, Song',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 10),
            Text(
              'What are you cooking today?',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
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
                          borderSide: BorderSide(
                              color: Colors.white), // Set border color
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          // Fetch recipes based on the search query
                          List<FoodRecipe> fetchedRecipes =
                              await apiService.searchFood(value);
                          setState(() {
                            recipes = fetchedRecipes;
                          });
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
                    onPressed: () {
                      // TODO: Implement filter
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recipes[index].title),
                    subtitle: Text(recipes[index].description),
                    leading: Image.network(recipes[index].imageUrl),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Set the current index
        onTap: (index) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FoodAllergy()));
        },
      ),
    );
  }
}
