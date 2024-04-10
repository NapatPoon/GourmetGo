import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gourmet_app/components/bottom_nav.dart';
import 'package:gourmet_app/pages/food_allergy_edit.dart';
import 'package:gourmet_app/pages/homepage.dart';
import 'package:gourmet_app/pages/search.dart';
import 'package:gourmet_app/pages/video.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: _buildFavoritesList(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
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

  Widget _buildFavoritesList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No favorites found'));
        }

        return ListView(
          padding: EdgeInsets.all(16.0),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return _buildFavoriteCard(context, data);
          }).toList(),
        );
      },
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Map<String, dynamic> data) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          data['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            data['image'],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteFavorite(data);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteFavorite(Map<String, dynamic> data) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('title', isEqualTo: data['title'])
          .where('image', isEqualTo: data['image'])
          .get();

      // Assuming there's only one document matching the title and image
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        print('Favorite deleted successfully!');
      } else {
        print('No matching favorite found to delete.');
      }
    } catch (e) {
      print('Error deleting favorite: $e');
      // Handle error as needed
    }
  }
}
