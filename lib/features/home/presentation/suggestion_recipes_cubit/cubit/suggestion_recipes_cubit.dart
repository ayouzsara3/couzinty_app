import 'package:bloc/bloc.dart';
import 'package:couzinty/features/home/data/repos/home_repo.dart';
import 'package:couzinty/features/home/presentation/suggestion_recipes_cubit/cubit/suggestion_recipes_state.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

class SuggestionRecipesCubit extends Cubit<SuggestionRecipesState> {
  final HomeRepo _homeRepo;

  SuggestionRecipesCubit(this._homeRepo) : super(SuggestionRecipesInitial());

  void setSearchResults(List<RecipeModel> searchResults) {
    emit(SuggestionRecipesSuccess(searchResults));
  }

  void clearSearchResults() {
    emit(SuggestionRecipesInitial());
  }

  void fetchRandomRecipes() async {
    try {
      final randomRecipes = await _homeRepo.fetchSliderRecipes();
      emit(SuggestionRecipesSuccess(randomRecipes));
    } catch (e) {
      emit(SuggestionRecipesError('Failed to fetch random recipes'));
    }
  }
}
