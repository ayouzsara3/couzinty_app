import 'package:bloc/bloc.dart';

import 'package:couzinty/features/shopping_list/data/repos/shopping_list_repo_impl.dart';

// Import the states
import 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final ShoppingListRepoImpl _shoppingListRepo;

  ShoppingListCubit(this._shoppingListRepo) : super(ShoppingListInitial());

  void fetchShoppingList(String userId) {
    emit(ShoppingListLoading());
    _shoppingListRepo.fetchShoppingList(userId).listen(
      (shoppingList) {
        emit(ShoppingListLoaded(shoppingList));
      },
      onError: (error) {
        emit(ShoppingListError(error.toString()));
      },
    );
  }
}
