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
      // Iterate over the list of recipe IDs
      for (String recipeId in recipesIds) {
        // Fetch the recipe document from Firestore
        final recipeSnapshot =
            await _firebaseFirestore.collection('recipes').doc(recipeId).get();

        // Check if the document exists
        if (recipeSnapshot.exists) {
          // Convert the Firestore document data into a RecipeModel object
          final recipeModel = RecipeModel.fromJson(recipeSnapshot.data()!);
          recipeModel.id = recipeId;
          // Add the RecipeModel to the result list
          recipesResult.add(recipeModel);
        }
      }
    } catch (error) {
      // Handle any errors that occur during the fetch process
      print('Error fetching favorite recipes: $error');
      // You might want to throw an exception or handle the error differently based on your app's requirements
    }

    return recipesResult;
  }
}
