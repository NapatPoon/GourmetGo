import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../components/bottom_nav.dart';
import '../models/recipe.dart'; // Assuming you have the same Recipe model
import '../services/api.dart'; // Assuming you have the same ApiService class

class Recommended extends StatefulWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  final ApiService apiService = ApiService();
  List<FoodRecipe> recommendedRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecommendedRecipes();
  }

  Future<void> fetchRecommendedRecipes() async {
    try {
      List<FoodRecipe> fetchedRecipes =
          await apiService.getRecommendedRecipes('thai');
      setState(() {
        recommendedRecipes = fetchedRecipes;
      });
    } catch (e) {
      // Handle error
    }
  }

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
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 10),
                Text(
                  'Recommended Recipes Today',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recommendedRecipes.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(15), // Make the image round
                        child: Image.network(
                          recommendedRecipes[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey,
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          recommendedRecipes[index].title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set text color to white
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
