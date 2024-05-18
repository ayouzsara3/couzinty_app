import 'package:bloc/bloc.dart';
import 'package:couzinty/features/search/data/repos/search_repo.dart';
import 'package:couzinty/features/upload/data/models/recipe_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;
  List<RecipeModel> recentSearchResults = [];

  SearchCubit(this._searchRepo) : super(SearchInitial());

  // Define a method to perform the search
  void search(String query) {
    emit(SearchLoading());
    _searchRepo.search(query).listen((searchResults) {
      recentSearchResults = searchResults;

      emit(SearchSuccess(searchResults));
    }, onError: (error) {
      emit(SearchError(error.toString()));
    });
  }

  List<RecipeModel> getRecentSearchResults() {
    return recentSearchResults;
  }
}
