import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/shopping_list/data/repos/shopping_list_repo.dart';

class ShoppingListRepoImpl implements ShoppingListRepo {
  final FirebaseFirestore _firebaseFirestore;

  ShoppingListRepoImpl({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<String>> fetchShoppingList(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null && data['shoppingList'] is List) {
        return List<String>.from(data['shoppingList']);
      } else {
        return <String>[];
      }
    });
  }
}
