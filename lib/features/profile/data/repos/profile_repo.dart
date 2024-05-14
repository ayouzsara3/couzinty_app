abstract class ProfileRepo {
  Future<String> updatePhoto(image);
  Future<String> updateUserName(newName);
  Future<void> forgetPassword(email);
  Future<void> signOut(context);
}
