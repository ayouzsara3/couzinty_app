import 'package:couzinty/features/categories/presentation/views/widgets/recipe_card.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';
import 'package:flutter/material.dart';

Widget buildRecipesListView(List<RecipeModel> recipes) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipes[index]);
      },
    ),
  );
}
