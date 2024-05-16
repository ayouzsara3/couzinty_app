import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/categories/data/repos/category_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepoImpl(this._firebaseFirestore);

  @override
  Future<List<RecipeModel>> fetchRecipesByCategory(String category) async {
    final List<RecipeModel> recipesResults = [];

    final recipesSnapshots = await _firebaseFirestore
        .collection('recipes')
        .where('category', isEqualTo: category)
        .where('isAccepted', isEqualTo: true)
        .get();

    for (var doc in recipesSnapshots.docs) {
      RecipeModel recipe = RecipeModel.fromJson(doc.data());
      recipe.id = doc.id;

      recipesResults.add(recipe);
    }

    print('recipesResult length ${recipesResults.length}');
    return recipesResults;
  }
}
