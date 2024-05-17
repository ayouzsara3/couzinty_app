import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/home/data/repos/home_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseFirestore _firebaseFirestore;

  HomeRepoImpl({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<List<RecipeModel>> fetchSliderRecipes() async {
    List<RecipeModel> recipesResult = [];

    final recipesSnapshots =
        await _firebaseFirestore.collection('recipes').get();

    final List<DocumentSnapshot> allRecipes = recipesSnapshots.docs;

    // Shuffle the list
    allRecipes.shuffle(Random());

    // Take the first 5
    var fiveRecipes = allRecipes.take(5).toList();

    for (var doc in fiveRecipes) {
      if (doc.exists) {
        final recipeModel =
            RecipeModel.fromJson(doc.data() as Map<String, dynamic>);
        recipeModel.id = doc.id;
        recipesResult.add(recipeModel);
      }
    }

    return recipesResult;
  }
}
