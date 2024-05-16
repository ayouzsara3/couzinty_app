import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class FavoritesRepo {
  Future<List<RecipeModel>> fetchFavoritesRecipes(recipesIds);
}
