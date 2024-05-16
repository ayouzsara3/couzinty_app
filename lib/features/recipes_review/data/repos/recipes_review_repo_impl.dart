import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/recipes_review/data/repos/recipes_review_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecipesReviewRepoImpl implements RecipesReviewRepo {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  RecipesReviewRepoImpl(this._firebaseStorage,
      {required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<List<RecipeModel>> fetchPendingRecipes() {
    // Create a StreamController to manage the stream
    StreamController<List<RecipeModel>> controller =
        StreamController<List<RecipeModel>>();

    _firebaseFirestore
        .collection('recipes')
        .where('isAccepted', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      List<RecipeModel> pendingRecipes = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        RecipeModel recipe = RecipeModel.fromJson(data);
        recipe.id = doc.id;
        pendingRecipes.add(recipe);
      }

      controller.add(pendingRecipes);
    });

    return controller.stream;
  }

  @override
  Future<void> acceptRecipe({required String recipeId}) async {
    // approve the recipe
    _firebaseFirestore
        .collection('recipes')
        .doc(recipeId)
        .update({'isAccepted': true});
  }

  @override
  Future<void> rejectRecipe({required String recipeId}) async {
    // delete the recipe from firestore
    await _firebaseFirestore.collection('recipes').doc(recipeId).delete();

    // delete the recipe image from firebase storage
    _firebaseStorage.ref().child('recipes_images/$recipeId.jpg').delete();
  }
}
