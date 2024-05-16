import 'package:bloc/bloc.dart';
import 'package:couzinty/features/favorites/data/repos/favorites_repo.dart';
import 'package:couzinty/features/favorites/presentation/viewmodel/fetch_favorite_recipes_cubit/fetch_favorite_recipes_state.dart';

class FetchFavoriteRecipesCubit extends Cubit<FetchFavoriteRecipesState> {
  final FavoritesRepo _favoritesRepo;
  FetchFavoriteRecipesCubit(this._favoritesRepo)
      : super(FetchFavoriteRecipesInitial());

  Future<void> fetchFavoriteRecips(recipesIds) async {
    emit(FetchFavoriteRecipesLoading());
    try {
      final recipes = await _favoritesRepo.fetchFavoritesRecipes(recipesIds);

      emit(FetchFavoriteRecipesSuccess(recipes));
    } catch (e) {
      print(e);
      emit(FetchFavoriteRecipesError(e.toString()));
    }
  }
}
