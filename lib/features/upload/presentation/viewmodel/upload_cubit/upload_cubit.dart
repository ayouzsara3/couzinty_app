import 'package:bloc/bloc.dart';
import 'package:couzinty/features/upload/data/repos/upload_repo.dart';
import 'package:couzinty/features/upload/presentation/viewmodel/upload_cubit/upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit(this.uploadRepo) : super(UploadInitial());
  final UploadRepo uploadRepo;

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
    emit(UploadLoading());
    try {
      await uploadRepo.uploadRecipe(
          name: name,
          image: image,
          category: category,
          difficulty: difficulty,
          cookingTime: cookingTime,
          ingredients: ingredients,
          instructions: ingredients,
          personsNumber: personsNumber,
          rate: rate);

      emit(UploadSuccess());
      print('uploadddedddddddd');
    } catch (e) {
      emit(UploadError("Signup failed: $e"));
    }
  }
}
