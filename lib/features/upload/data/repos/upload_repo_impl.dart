import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/upload/data/repos/upload_repo.dart';
import 'package:couzinty/features/upload/data/services/firebase_storage_service.dart';

class UploadRepoImpl implements UploadRepo {
  final FirebaseFirestore _firestore;
  final FirebaseStorageService _firebaseStorageService;

  UploadRepoImpl(this._firebaseStorageService,
      {required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<void> uploadRecipe(
      {required name,
      required image,
      required category,
      required difficulty,
      required cookingTime,
      required ingredients,
      required instructions,
      required rate,
      required personsNumber}) async {
    DocumentReference recipeRef = await _firestore.collection('recipes').add({
      'name': name,
      'image': '',
      'category': category,
      'difficulty': difficulty,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'instructions': instructions,
      'rate': rate,
      'personsNumber': personsNumber,
    });

    // save image into firebase Storage
    final imageUrl =
        await _firebaseStorageService.saveRecipeImage(recipeRef, image);

    // save the imageUrl on firestore
    await recipeRef.update({'image': imageUrl});
  }
}
