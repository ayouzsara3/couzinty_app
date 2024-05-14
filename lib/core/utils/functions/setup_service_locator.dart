import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couzinty/features/auth/data/repos/auth_repo_impl.dart';
import 'package:couzinty/features/auth/data/services/firestore_services.dart';
import 'package:couzinty/features/profile/data/repos/profile_repo_impl.dart';
import 'package:couzinty/features/search/data/repos/search_repo_impl.dart';
import 'package:couzinty/features/upload/data/repos/upload_repo_impl.dart';
import 'package:couzinty/features/upload/data/services/firebase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  GetIt.I.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  GetIt.I.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  GetIt.I
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  final firestore = GetIt.I<FirebaseFirestore>();
  final firestoreService = FirestoreService(firestore: firestore);
  GetIt.I.registerLazySingleton(() => firestoreService);

  final firebaseStorage = GetIt.I<FirebaseStorage>();
  final firebaseStorageService =
      FirebaseStorageService(firebaseStorage: firebaseStorage);
  GetIt.I.registerLazySingleton(() => firebaseStorageService);

  final firebaseAuth = GetIt.I<FirebaseAuth>();
  final authRepo = AuthRepoImpl(firebaseAuth, firestoreService);
  GetIt.I.registerLazySingleton(() => authRepo);

  final uploadRepo =
      UploadRepoImpl(firebaseStorageService, firestore: firestore);

  GetIt.I.registerLazySingleton(() => uploadRepo);

  final profileRepo =
      ProfileRepoImpl(firebaseStorage, firestore, firebaseAuth: firebaseAuth);
  GetIt.I.registerLazySingleton(() => profileRepo);

  final searchRepo = SearchRepoImpl(firebaseFirestore: firestore);
  GetIt.I.registerLazySingleton(() => searchRepo);
}
