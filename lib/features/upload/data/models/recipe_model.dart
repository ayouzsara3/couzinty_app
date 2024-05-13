import 'package:couzinty/features/categories/data/models/category_model.dart';

class RecipeModel {
  final String name;
  final String image;
  final Category category;
  final String difficulty;
  final int cookingTime;
  final List<String> ingredients;
  final List<String> instructions;
  final double rate;
  final int personsNumber;

  RecipeModel(
      {required this.name,
      required this.image,
      required this.category,
      required this.difficulty,
      required this.cookingTime,
      required this.ingredients,
      required this.instructions,
      required this.rate,
      required this.personsNumber});
}
