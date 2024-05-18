import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class RecipesReviewRepo {
  Stream<List<RecipeModel>> fetchRecipes(String mode, String userId);
  Future<void> acceptRecipe({required String recipeId});
  Future<void> rejectRecipe({required String recipeId});
}
