import 'package:bloc/bloc.dart';
import 'package:couzinty/features/categories/data/repos/category_repo.dart';
import 'package:couzinty/features/categories/presentation/viewmodel/fetch_recipes_by_category_cubit/fetch_recipes_by_category_state.dart';

class FetchRecipesByCategoryCubit extends Cubit<FetchRecipesByCategoryState> {
  final CategoryRepo _categoryRepo;
  FetchRecipesByCategoryCubit(this._categoryRepo)
      : super(FetchRecipesByCategoryInitial());

  Future<void> fetchRecipes(String category) async {
    emit(FetchRecipesByCategoryLoading());
    try {
      final recipes = await _categoryRepo.fetchRecipesByCategory(category);

      emit(FetchRecipesByCategorySuccess(recipes));
    } catch (e) {
      print(e);
      emit(FetchRecipesByCategoryError(e.toString()));
    }
  }
}
