import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/home/data/repos/home_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseFirestore _firebaseFirestore;

  HomeRepoImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<List<RecipeModel>> fetchSliderRecipes() async {
    List<RecipeModel> recipesResult = [];

    final recipesSnapshots =
        await _firebaseFirestore.collection('recipes').limit(5).get();

    for (var doc in recipesSnapshots.docs) {
      if (doc.exists) {
        final recipeModel = RecipeModel.fromJson(doc.data());
        recipeModel.id = doc.id;
        recipesResult.add(recipeModel);
      }
    }

    return recipesResult;
  }
}
