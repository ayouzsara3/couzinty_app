abstract class ShoppingListState {}

class ShoppingListInitial extends ShoppingListState {}

class ShoppingListLoading extends ShoppingListState {}

class ShoppingListLoaded extends ShoppingListState {
  final List<String> shoppingList;

  ShoppingListLoaded(this.shoppingList);
}

class ShoppingListError extends ShoppingListState {
  final String message;

  ShoppingListError(this.message);
}
