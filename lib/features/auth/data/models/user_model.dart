import 'package:couzinty/core/utils/functions/arrays_equal.dart';

class UserModel {
  final String id;
  final String email;
  final String userName;
  final String role;
  final String image;
  final List<String> favorites;
  List<String>? shoppingList;

  UserModel(
      {required this.id,
      required this.email,
      required this.userName,
      required this.role,
      required this.image,
      required this.favorites,
      required this.shoppingList});

  UserModel copyWith({
    String? userName,
    String? image,
    String? recipeId,
    List<String>? shoppingList,
  }) {
    if (recipeId != null) {
      if (favorites.contains(recipeId)) {
        favorites.remove(recipeId);
      } else {
        favorites.add(recipeId);
      }
    }
    if (shoppingList != null) {
      if (arraysEqual(shoppingList, this.shoppingList!)) {
        this.shoppingList!.clear();
      } else {
        this.shoppingList = shoppingList;
      }
    }

    return UserModel(
      id: id,
      email: email,
      userName: userName ?? this.userName,
      role: role,
      image: image ?? this.image,
      favorites: favorites,
      shoppingList: shoppingList ?? this.shoppingList,
    );
  }
}
