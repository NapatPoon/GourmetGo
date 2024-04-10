import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../models/recipe_vid.dart';
import 'package:gourmet_app/config.dart';

class ApiService {
  final String apiKey = Config.apiKey;
  // final String apiLink =   ;

  get cuisine => null;

  Future<List<FoodRecipe>> searchFood(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query${cuisine != null ? '&cuisine=$cuisine' : ''}&apiKey=$apiKey&addRecipeInformation=True&addRecipeInstructions=True&number=10&excludeIngredients=pork,fish,prawn,Shrimp'));
    if (response.statusCode == 200) {
      // print(response.body);
      return (json.decode(response.body)['results'] as List)
          .map((json) => FoodRecipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<FoodRecipe>> complexSearch(String query) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return (json.decode(response.body)['results'] as List)
          .map((json) => FoodRecipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<RecipeVideo>> getRecipeVideo(String query) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/food/videos/search?apiKey=$apiKey&query=$query');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final videoResponse = RecipeVideosResponse.fromJson(jsonBody);
      return videoResponse.videos;
    } else {
      throw Exception('Failed to load recipe videos');
    }
  }

  Future<List<FoodRecipe>> getRecommendedRecipes(String query) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=$apiKey&number=5');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return (json.decode(response.body)['results'] as List)
          .map((json) => FoodRecipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<FoodRecipe>> searchExclude(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query${cuisine != null ? '&cuisine=$cuisine' : ''}&apiKey=$apiKey&addRecipeInformation=True&addRecipeInstructions=True&number=3&excludeIngredients='));
    if (response.statusCode == 200) {
      // print(response.body);
      return (json.decode(response.body)['results'] as List)
          .map((json) => FoodRecipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
