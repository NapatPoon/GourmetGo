class FoodRecipe {
  final int id;
  final String title;
  final String image;
  final String imgType;
  final List<String> cuisines;
  final String summary;
  final String spoonacularSourceUrl;
  final List<Map<String, dynamic>> analyzedInstructions;

  FoodRecipe({
    required this.id,
    required this.title,
    required this.image,
    required this.imgType,
    required this.cuisines,
    required this.summary,
    required this.spoonacularSourceUrl,
    required this.analyzedInstructions,
  });

  factory FoodRecipe.fromJson(Map<String, dynamic> json) {
    return FoodRecipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imgType: json['imageType'] ?? '',
      cuisines: List<String>.from(json['cuisines'] ?? []),
      summary: json['summary'] ?? '',
      spoonacularSourceUrl: json['spoonacularSourceUrl'] ?? '',
      analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>?)
              ?.map((instruction) => {
                    'name': instruction['name'],
                    'steps': (instruction['steps'] as List<dynamic>?)
                        ?.map((step) => {
                              'number': step['number'],
                              'step': step['step'],
                              'ingredients':
                                  (step['ingredients'] as List<dynamic>?)
                                      ?.map((ingredient) => {
                                            'id': ingredient['id'],
                                            'name': ingredient['name'],
                                            'localizedName':
                                                ingredient['localizedName'],
                                            'image': ingredient['image'],
                                          })
                                      ?.toList(),
                              'equipment': (step['equipment'] as List<dynamic>?)
                                  ?.map((equipment) => {
                                        'id': equipment['id'],
                                        'name': equipment['name'],
                                        'localizedName':
                                            equipment['localizedName'],
                                        'image': equipment['image'],
                                      })
                                  ?.toList(),
                              'length': step['length'],
                            })
                        ?.toList(),
                  })
              ?.toList() ??
          [],
    );
  }
}
