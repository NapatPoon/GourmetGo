class FoodRecipe {
  final String title;
  final String image;
  final String? cuisine; // Making cuisine optional

  FoodRecipe({
    required this.title,
    required this.image,
    this.cuisine, // Making cuisine optional in the constructor
  });

  factory FoodRecipe.fromJson(Map<String, dynamic> json) {
    return FoodRecipe(
      title: json['title'],
      image: json['image'],
      cuisine: json['cuisine'], // Assigning value to cuisine attribute
    );
  }
}
