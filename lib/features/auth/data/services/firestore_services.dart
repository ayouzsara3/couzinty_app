import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/auth/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> saveUserData(
      String userId, String userName, String email, String role) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'userName': userName,
        'email': email,
        'role': role,
        'image': '',
        'favorites': [],
        'shoppingList': '',
      });
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      final userData = await _firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        return UserModel(
          id: userId,
          userName: userData.data()?['userName'] ?? '',
          email: userData.data()?['email'] ?? '',
          role: userData.data()?['role'] ?? '',
          image: userData.data()?['image'] ?? '',
          favorites: List<String>.from(userData.data()?['favorites'] ?? []),
          shoppingList: userData.data()?['shoppingList'] ?? '',
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
