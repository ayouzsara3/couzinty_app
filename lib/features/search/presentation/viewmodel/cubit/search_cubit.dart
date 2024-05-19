import 'package:bloc/bloc.dart';
import 'package:couzinty/features/search/data/repos/search_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;
  List<RecipeModel> recentSearchResults = [];

  SearchCubit(this._searchRepo) : super(SearchInitial());

  // Define a method to perform the search
  void search(String query, bool isSearchByIngredient,
      {String? category, double? cookingTime, String? difficulty}) {
    emit(SearchLoading());

    print(
        'category: $category , cookingTime: $cookingTime , difficulty: $difficulty');
    Stream<List<RecipeModel>> searchStream = isSearchByIngredient
        ? _searchRepo.searchByIngredients(query,
            category: category,
            cookingTime: cookingTime,
            difficulty: difficulty)
        : _searchRepo.searchByName(query,
            category: category,
            cookingTime: cookingTime,
            difficulty: difficulty);

    searchStream.listen((recipes) {
      emit(SearchSuccess(recipes));
    }).onError((error) {
      emit(SearchError(error.toString()));
    });
  }

  List<RecipeModel> getRecentSearchResults() {
    return recentSearchResults;
  }
}
