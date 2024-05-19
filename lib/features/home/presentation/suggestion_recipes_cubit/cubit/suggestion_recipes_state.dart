import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class SuggestionRecipesState {}

class SuggestionRecipesInitial extends SuggestionRecipesState {}

class SuggestionRecipesSuccess extends SuggestionRecipesState {
  final List<RecipeModel> recipes;

  SuggestionRecipesSuccess(this.recipes);
}

final class SuggestionRecipesError extends SuggestionRecipesState {
  final String message;

  SuggestionRecipesError(this.message);
}
