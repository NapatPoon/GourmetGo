import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailsPage extends StatelessWidget {
  final FoodRecipe recipe;

  const RecipeDetailsPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Colors.teal, // Added teal color to app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                recipe.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Added teal color to recipe title
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.image,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Instructions:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Added teal color to instructions
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  recipe.analyzedInstructions.expand<Widget>((instruction) {
                return (instruction['steps'] as List<dynamic>)
                    .map<Widget>((step) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${step['number']}:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.teal, // Added teal color to step number
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${step['step']}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ingredients: ${_formatIngredients(step['ingredients'])}',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color:
                                Colors.teal, // Added teal color to ingredients
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(), // Add a divider between steps
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                }).toList();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatIngredients(List<dynamic> ingredients) {
    return ingredients.map((ingredient) {
      String name = ingredient['name'];
      return name.substring(0, 1).toUpperCase() + name.substring(1);
    }).join(", ");
  }
}
