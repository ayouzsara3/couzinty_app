import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/search/data/repos/search_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class SearchRepoImpl implements SearchRepo {
  final FirebaseFirestore _firebaseFirestore;

  SearchRepoImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @override
  Stream<List<RecipeModel>> searchByName(String query,
      {String? category, double? cookingTime, String? difficulty}) {
    StreamController<List<RecipeModel>> controller =
        StreamController<List<RecipeModel>>();
    Timer? debounceTimer;

    _firebaseFirestore
        .collection('recipes')
        .where('isAccepted', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      debounceTimer?.cancel();

      debounceTimer = Timer(const Duration(milliseconds: 500), () {
        List<RecipeModel> searchResults = [];
        Set<String> addedRecipeIds = {};

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();

          if (data['name']
              .toString()
              .toLowerCase()
              .startsWith(query.toLowerCase())) {
            RecipeModel recipe = RecipeModel.fromJson(data);
            recipe.id = doc.id;
            if (_matchesFilters(recipe, category, cookingTime, difficulty)) {
              _addRecipeIfNotExists(searchResults, addedRecipeIds, recipe);
            }
          }
        }

        controller.add(searchResults);
      });
    });

    return controller.stream;
  }

  @override
  Stream<List<RecipeModel>> searchByIngredients(String query,
      {String? category, double? cookingTime, String? difficulty}) {
    StreamController<List<RecipeModel>> controller =
        StreamController<List<RecipeModel>>();
    Timer? debounceTimer;

    _firebaseFirestore
        .collection('recipes')
        .where('isAccepted', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      debounceTimer?.cancel();

      debounceTimer = Timer(const Duration(milliseconds: 500), () {
        List<RecipeModel> searchResults = [];
        Set<String> addedRecipeIds = {};

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          List<dynamic> ingredientsDynamic = data['ingredients'];
          List<String> ingredients = ingredientsDynamic.cast<String>();

          for (var ingredient in ingredients) {
            if (ingredient
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
              RecipeModel recipe = RecipeModel.fromJson(data);
              recipe.id = doc.id;
              if (_matchesFilters(recipe, category, cookingTime, difficulty)) {
                _addRecipeIfNotExists(searchResults, addedRecipeIds, recipe);
                break;
              }
            }
          }
        }

        controller.add(searchResults);
      });
    });

    return controller.stream;
  }

  bool _matchesFilters(RecipeModel recipe, String? category,
      double? cookingTime, String? difficulty) {
    bool matchesCategory = category == null || recipe.category == category;
    bool matchesCookingTime =
        cookingTime == null || recipe.cookingTime == cookingTime;
    bool matchesDifficulty =
        difficulty == null || recipe.difficulty == difficulty;

    return matchesCategory && matchesCookingTime && matchesDifficulty;
  }

  void _addRecipeIfNotExists(List<RecipeModel> searchResults,
      Set<String> addedRecipeIds, RecipeModel recipe) {
    if (!addedRecipeIds.contains(recipe.id)) {
      searchResults.add(recipe);
      addedRecipeIds.add(recipe.id);
    }
  }
}
