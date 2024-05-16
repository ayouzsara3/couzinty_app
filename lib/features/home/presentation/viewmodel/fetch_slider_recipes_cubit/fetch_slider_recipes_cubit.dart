import 'package:bloc/bloc.dart';
import 'package:couzinty/features/home/data/repos/home_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

part 'fetch_slider_recipes_state.dart';

class FetchSliderRecipesCubit extends Cubit<FetchSliderRecipesState> {
  final HomeRepo _homeRepo;
  FetchSliderRecipesCubit(this._homeRepo) : super(FetchSliderRecipesInitial());

  Future<void> fetchSliderRecipes() async {
    emit(FetchSliderRecipesLoading());
    try {
      final recipes = await _homeRepo.fetchSliderRecipes();

      emit(FetchSliderRecipesSuccess(recipes));
    } catch (e) {
      emit(FetchSliderRecipesError(e.toString()));
    }
  }
}
