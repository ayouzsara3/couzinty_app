part of 'fetch_slider_recipes_cubit.dart';

abstract class FetchSliderRecipesState {}

final class FetchSliderRecipesInitial extends FetchSliderRecipesState {}

final class FetchSliderRecipesLoading extends FetchSliderRecipesState {}

final class FetchSliderRecipesSuccess extends FetchSliderRecipesState {
  final List<RecipeModel> recipes;

  FetchSliderRecipesSuccess(this.recipes);
}

final class FetchSliderRecipesError extends FetchSliderRecipesState {
  final String message;

  FetchSliderRecipesError(this.message);
}
