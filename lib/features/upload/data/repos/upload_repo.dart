abstract class UploadRepo {
  Future<void> uploadRecipe(
      {required name,
      required image,
      required category,
      required difficulty,
      required cookingTime,
      required ingredients,
      required instructions,
      required rate,
      required personsNumber});
}
