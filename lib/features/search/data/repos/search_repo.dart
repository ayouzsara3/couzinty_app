import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class SearchRepo {
  Stream<List<RecipeModel>> searchByName(String query,
      {String? category, double? cookingTime, String? difficulty});
  Stream<List<RecipeModel>> searchByIngredients(String query,
      {String? category, double? cookingTime, String? difficulty});
}
