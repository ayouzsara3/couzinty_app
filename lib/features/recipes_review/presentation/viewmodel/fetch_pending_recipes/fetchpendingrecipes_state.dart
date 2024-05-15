import 'package:couzinty/features/upload/data/models/recipe_model.dart';

abstract class FetchPendingRecipesState {}

final class FetchPendingRecipesInitial extends FetchPendingRecipesState {}

final class FetchPendingRecipesLoading extends FetchPendingRecipesState {}

final class FetchPendingRecipesSuccess extends FetchPendingRecipesState {
  final List<RecipeModel> recipes;

  FetchPendingRecipesSuccess(this.recipes);
}

final class FetchPendingRecipesError extends FetchPendingRecipesState {
  final String message;

  FetchPendingRecipesError(this.message);
}
