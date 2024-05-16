import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class HomeRepo {
  Future<List<RecipeModel>> fetchSliderRecipes();
}
