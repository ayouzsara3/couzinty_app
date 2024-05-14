class RecipeModel {
  String id;
  final String name;
  final String image;
  final String category;
  final String difficulty;
  final int cookingTime;
  final List<String> ingredients;
  final List<String> instructions;
  final double rate;
  final int personsNumber;
  final bool isAccepted;

  RecipeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.difficulty,
    required this.cookingTime,
    required this.ingredients,
    required this.instructions,
    required this.rate,
    required this.personsNumber,
    required this.isAccepted,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      image: json['image'].toString(),
      category: json['category'].toString(),
      difficulty: json['difficulty'].toString(),
      cookingTime: json['cookingTime'] as int,
      ingredients: (json['ingredients'] as List<dynamic>).cast<String>(),
      instructions: (json['instructions'] as List<dynamic>).cast<String>(),
      rate: json['rate'] as double,
      personsNumber: json['personsNumber'] as int,
      isAccepted: json['isAccepted'] as bool,
    );
  }
}
