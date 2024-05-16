import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class CategoryRepo {
  Future<List<RecipeModel>> fetchRecipesByCategory(String category);

  Future<void> favoriteRecipeAction(
      String action, dynamic recipeId, String userId);

  Future<void> shoppingListAction(
      String action, dynamic recipeId, String userId);
}
