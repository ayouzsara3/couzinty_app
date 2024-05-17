abstract class ShoppingListRepo {
  Stream<List<String>> fetchShoppingList(String userId);
}
