import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class FetchRecipesByCategoryState {}

final class FetchRecipesByCategoryInitial extends FetchRecipesByCategoryState {}

final class FetchRecipesByCategoryLoading extends FetchRecipesByCategoryState {}

final class FetchRecipesByCategorySuccess extends FetchRecipesByCategoryState {
  final List<RecipeModel> recipes;

  FetchRecipesByCategorySuccess(this.recipes);
}

final class FetchRecipesByCategoryError extends FetchRecipesByCategoryState {
  final String message;

  FetchRecipesByCategoryError(this.message);
}
