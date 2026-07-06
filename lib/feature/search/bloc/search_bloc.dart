import 'package:bloc/bloc.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/search/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final List<MovieModel> movies =
          await repository.multiSearch(event.query.trim());

      emit(SearchLoaded(movies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}
