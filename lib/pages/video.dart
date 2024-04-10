import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs
import 'package:gourmet_app/components/bottom_nav.dart';
import 'package:gourmet_app/pages/favorite.dart';
import 'package:gourmet_app/pages/food_allergy_edit.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/search.dart';
import 'package:gourmet_app/services/api.dart';
import '../models/recipe_vid.dart';

class RecipeVideoPage extends StatefulWidget {
  const RecipeVideoPage({Key? key}) : super(key: key);

  @override
  _RecipeVideoPageState createState() => _RecipeVideoPageState();
}

class _RecipeVideoPageState extends State<RecipeVideoPage> {
  final ApiService apiService = ApiService();
  List<RecipeVideo> recipeVideo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Video',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for food videos",
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          try {
                            List<RecipeVideo> fetchedRecipes =
                                await apiService.getRecipeVideo(value);
                            setState(() {
                              recipeVideo = fetchedRecipes;
                            });
                          } catch (e) {
                            // Handle error
                          }
                        } else {
                          setState(() {
                            recipeVideo = [];
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: recipeVideo.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      recipeVideo[index].title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Views: ${recipeVideo[index].views.toString()}',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Length: ${recipeVideo[index].length.toString()}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    // Wrap the thumbnail image in GestureDetector
                    leading: GestureDetector(
                      onTap: () async {
                        String id = recipeVideo[index].youTubeId.toString();
                        final url =
                            Uri.parse('https://youtube.com/watch?v=$id');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) ;
                        print(url);
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(recipeVideo[index].thumbnail),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
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

  // Function to launch YouTube URL in the default browser
  void launchYoutubeUrl(String youTubeId) async {
    final Uri url = Uri.parse('youtube.com/watch?v=$youTubeId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
