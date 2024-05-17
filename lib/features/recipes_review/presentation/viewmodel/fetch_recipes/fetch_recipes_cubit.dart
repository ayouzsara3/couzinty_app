import 'package:bloc/bloc.dart';
import 'package:couzinty/features/recipes_review/data/repos/recipes_review_repo.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_recipes/fetch_recipes_state.dart';

class FetchRecipesCubit extends Cubit<FetchRecipesState> {
  final RecipesReviewRepo _recipesReviewRepo;
  FetchRecipesCubit(this._recipesReviewRepo)
      : super(FetchPendingRecipesInitial());

  void fetchPendingRecipes(String mode) {
    emit(FetchRecipesLoading());
    _recipesReviewRepo.fetchRecipes(mode).listen((recipes) {
      emit(FetchRecipesSuccess(recipes));
    }, onError: (error) {
      emit(FetchRecipesError(error.toString()));
    });
  }
}
