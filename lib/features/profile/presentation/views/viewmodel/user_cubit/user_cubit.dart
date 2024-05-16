import 'package:couzinty/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define a Cubit to manage the user data
class UserCubit extends Cubit<UserModel> {
  UserCubit(super.key);

  // Method to set user data
  void setUser(UserModel user) {
    emit(user);
  }

  // Method to update user data
  void updateUser({
    String? userName,
    String? image,
    String? recipeId,
    List<String>? shoppingList,
  }) {
    UserModel updatedUser = state.copyWith(
      userName: userName ?? state.userName,
      image: image ?? state.image,
      recipeId: recipeId,
      shoppingList: shoppingList,
    );
    emit(updatedUser);
  }
}
