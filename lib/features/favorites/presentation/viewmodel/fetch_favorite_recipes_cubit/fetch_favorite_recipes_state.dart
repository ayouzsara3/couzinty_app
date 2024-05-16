import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class FetchFavoriteRecipesState {}

final class FetchFavoriteRecipesInitial extends FetchFavoriteRecipesState {}

final class FetchFavoriteRecipesLoading extends FetchFavoriteRecipesState {}

final class FetchFavoriteRecipesSuccess extends FetchFavoriteRecipesState {
  final List<RecipeModel> recipes;

  FetchFavoriteRecipesSuccess(this.recipes);
}

final class FetchFavoriteRecipesError extends FetchFavoriteRecipesState {
  final String message;

  FetchFavoriteRecipesError(this.message);
}
