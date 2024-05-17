import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class FetchRecipesState {}

final class FetchPendingRecipesInitial extends FetchRecipesState {}

final class FetchRecipesLoading extends FetchRecipesState {}

final class FetchRecipesSuccess extends FetchRecipesState {
  final List<RecipeModel> recipes;

  FetchRecipesSuccess(this.recipes);
}

final class FetchRecipesError extends FetchRecipesState {
  final String message;

  FetchRecipesError(this.message);
}
