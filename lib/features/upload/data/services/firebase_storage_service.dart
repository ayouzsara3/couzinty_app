import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage;

  FirebaseStorageService({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  Future<String?> saveRecipeImage(DocumentReference recipeRef, image) async {
    try {
      final storageRef = _firebaseStorage
          .ref()
          .child('recipes_images')
          .child('${recipeRef.id}.jpg');
      await storageRef.putFile(image!);
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
