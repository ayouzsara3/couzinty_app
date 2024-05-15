enum RecipeActionStatus { initial, loading, success, failure }

class RecipeActionState {
  final RecipeActionStatus status;
  final String? errorMessage;

  const RecipeActionState({
    this.status = RecipeActionStatus.initial,
    this.errorMessage,
  });

  RecipeActionState copyWith({
    RecipeActionStatus? status,
    String? errorMessage,
  }) {
    return RecipeActionState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
