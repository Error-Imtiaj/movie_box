import 'package:bloc/bloc.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/search/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  int _currentPage = 1;
  String _currentQuery = '';
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;
  final List<MovieModel> _movies = [];

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<ClearSearch>(_onClearSearch);
    on<LoadMoreSearch>(_onLoadMoreSearch);
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    _currentQuery = event.query.trim();
    _currentPage = 1;
    _hasReachedMax = false;
    _movies.clear();

    emit(const SearchLoading());

    try {
      final movies = await repository.multiSearch(
        query: _currentQuery,
        page: _currentPage,
      );

      _movies.addAll(movies);
      _hasReachedMax = movies.isEmpty;

      emit(SearchLoaded(List<MovieModel>.from(_movies)));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onLoadMoreSearch(
    LoadMoreSearch event,
    Emitter<SearchState> emit,
  ) async {
    if (_isLoadingMore || _hasReachedMax || _currentQuery.isEmpty) {
      return;
    }

    _isLoadingMore = true;

    try {
      final movies = await repository.multiSearch(
        query: _currentQuery,
        page: ++_currentPage,
      );

      if (movies.isEmpty) {
        _hasReachedMax = true;
      } else {
        _movies.addAll(movies);
        emit(SearchLoaded(List<MovieModel>.from(_movies)));
      }
    } catch (_) {
    } finally {
      _isLoadingMore = false;
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    _currentPage = 1;
    _currentQuery = '';
    _movies.clear();
    _isLoadingMore = false;
    _hasReachedMax = false;
    emit(const SearchInitial());
  }
}
