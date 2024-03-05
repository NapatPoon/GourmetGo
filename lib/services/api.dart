import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import 'package:gourmet_app/config.dart';

class ApiService {
  final String apiKey = Config.apiKey;

  get cuisine => null;

  Future<List<FoodRecipe>> searchFood(String query) async {
    var url = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=$query${cuisine != null ? '&cuisine=$cuisine' : ''}&apiKey=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return (json.decode(response.body)['results'] as List)
          .map((json) => FoodRecipe.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
