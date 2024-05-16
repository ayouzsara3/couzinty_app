import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/favorites/data/repos/favorites_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final FirebaseFirestore _firebaseFirestore;

  FavoritesRepoImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<List<RecipeModel>> fetchFavoritesRecipes(recipesIds) async {
    final List<RecipeModel> recipesResult = [];

    try {
      for (String recipeId in recipesIds) {
        final recipeSnapshot =
            await _firebaseFirestore.collection('recipes').doc(recipeId).get();

        if (recipeSnapshot.exists) {
          final recipeModel = RecipeModel.fromJson(recipeSnapshot.data()!);
          recipeModel.id = recipeId;
          recipesResult.add(recipeModel);
        }
      }
    } catch (error) {
      print('Error fetching favorite recipes: $error');
    }

    return recipesResult;
  }
}
