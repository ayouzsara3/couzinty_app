import 'package:couzinty/features/recipes_review/data/repos/recipes_review_repo.dart';
import 'package:couzinty/features/recipes_review/presentation/viewmodel/recipe_action_cubit/recipe_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeActionCubit extends Cubit<RecipeActionState> {
  final RecipesReviewRepo _recipesReviewRepo;
  RecipeActionCubit(this._recipesReviewRepo) : super(const RecipeActionState());

  Future<void> performRecipeAction(
      {required String action, required String recipeId}) async {
    emit(state.copyWith(status: RecipeActionStatus.loading));
    try {
      if (action == 'delete') {
        await _recipesReviewRepo.rejectRecipe(recipeId: recipeId);
      } else {
        await _recipesReviewRepo.acceptRecipe(recipeId: recipeId);
      }
      emit(state.copyWith(status: RecipeActionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: RecipeActionStatus.failure,
        errorMessage: 'Failed to perform recipe action: $e',
      ));
    }
  }
}
