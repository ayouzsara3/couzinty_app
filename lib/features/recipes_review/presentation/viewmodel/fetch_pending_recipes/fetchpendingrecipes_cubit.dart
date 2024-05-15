import 'package:bloc/bloc.dart';
import 'package:couzinty/features/recipes_review/data/repos/recipes_review_repo.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/fetch_pending_recipes/fetchpendingrecipes_state.dart';

class FetchPendingRecipesCubit extends Cubit<FetchPendingRecipesState> {
  final RecipesReviewRepo _recipesReviewRepo;
  FetchPendingRecipesCubit(this._recipesReviewRepo)
      : super(FetchPendingRecipesInitial());

  void fetchPendingRecipes() {
    emit(FetchPendingRecipesLoading());
    _recipesReviewRepo.fetchPendingRecipes().listen((recipes) {
      emit(FetchPendingRecipesSuccess(recipes));
    }, onError: (error) {
      emit(FetchPendingRecipesError(error.toString()));
    });
  }
}
