import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class CategoryRepo {
  Future<List<RecipeModel>> fetchRecipesByCategory(String category);
}
