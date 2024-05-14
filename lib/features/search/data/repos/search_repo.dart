import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class SearchRepo {
  Stream<List<RecipeModel>> search(String query);
}
