import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/search/data/repos/search_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class SearchRepoImpl implements SearchRepo {
  final FirebaseFirestore _firebaseFirestore;

  SearchRepoImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<List<RecipeModel>> search(String query) {
    // Create a StreamController to manage the stream
    StreamController<List<RecipeModel>> controller =
        StreamController<List<RecipeModel>>();

    // We use debounceTimer to avoid the huge number of requests to server
    Timer? debounceTimer;

    _firebaseFirestore.collection('recipes').snapshots().listen((snapshot) {
      // Cancel the previous timer if it's active
      debounceTimer?.cancel();

      debounceTimer = Timer(const Duration(milliseconds: 500), () {
        List<RecipeModel> searchResults = [];
        Set<String> addedRecipeIds = {};

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();

          // Check if the recipe name matches the query
          if (data['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            // If it matches, create a RecipeModel instance and add it to the search result
            RecipeModel recipe = RecipeModel.fromJson(data);
            recipe.id = doc.id;
            _addRecipeIfNotExists(searchResults, addedRecipeIds, recipe);
          }

          // // Check if any ingredient matches the query
          List<dynamic> ingredientsDynamic = data['ingredients'];
          List<String> ingredients = ingredientsDynamic.cast<String>();
          for (var ingredient in ingredients) {
            if (ingredient
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
              RecipeModel recipe = RecipeModel.fromJson(data);
              recipe.id = doc.id;
              _addRecipeIfNotExists(searchResults, addedRecipeIds, recipe);
              break; // Break loop if any ingredient matches
            }
          }
        }

        // Add the search results to the stream
        controller.add(searchResults);
      });
    });

    return controller.stream;
  }

  void _addRecipeIfNotExists(List<RecipeModel> searchResults,
      Set<String> addedRecipeIds, RecipeModel recipe) {
    if (!addedRecipeIds.contains(recipe.id)) {
      searchResults.add(recipe);
      addedRecipeIds.add(recipe.id);
    }
  }
}
