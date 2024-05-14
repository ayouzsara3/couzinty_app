import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/core/utils/app_router.dart';
import 'package:couzinty/features/auth/presentation/viewmodel/signin_cubit/signin_cubit.dart';
import 'package:couzinty/features/profile/data/repos/profile_repo.dart';
import 'package:couzinty/features/profile/presentation/views/viewmodel/user_cubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileRepoImpl implements ProfileRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepoImpl(this._firebaseStorage, this._firebaseFirestore,
      {required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<void> forgetPassword(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> signOut(context) async {
    await context.read<SigninCubit>().logout();
    GoRouter.of(context).pushReplacement(AppRouter.kSignInView);
  }

  @override
  Future<String> updatePhoto(image) async {
    // upload image to firebase storage
    final storageRef = _firebaseStorage
        .ref()
        .child('user_images')
        .child('${_firebaseAuth.currentUser!.uid}.jpg');
    await storageRef.putFile(image!);
    final imageUrl = await storageRef.getDownloadURL();

    // save the image url on firestore
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      'image': imageUrl,
    });

    return imageUrl;
  }

  @override
  Future<String> updateUserName(newName) async {
    // upload the userName into firestore
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update({
      'userName': newName,
    });

    return newName;
  }
}
