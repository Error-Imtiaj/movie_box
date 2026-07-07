import 'package:bloc/bloc.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/suggest/repository/suggest_repository.dart';

part 'suggest_event.dart';
part 'suggest_state.dart';

class SuggestBloc extends Bloc<SuggestEvent, SuggestState> {
  final SuggestRepository repository;

  int _page = 1;
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;
  String? _selectedMood;
  int? _selectedGenreId;
  final List<MovieModel> _movies = [];

  SuggestBloc(this.repository) : super(const SuggestInitial()) {
    on<LoadSuggestions>(_onLoadSuggestions);
    on<SurpriseMe>(_onSurpriseMe);
    on<SelectMood>(_onSelectMood);
    on<SelectGenre>(_onSelectGenre);
    on<LoadMoreSuggestions>(_onLoadMoreSuggestions);
    on<RefreshSuggestions>(_onRefreshSuggestions);
  }

  Future<void> _onLoadSuggestions(
    LoadSuggestions event,
    Emitter<SuggestState> emit,
  ) async {
    emit(const SuggestLoading());

    _page = 1;
    _movies.clear();
    _hasReachedMax = false;

    try {
      final movies = await repository.getSuggestions(
        page: _page,
        mood: _selectedMood,
        genreId: _selectedGenreId,
      );

      _movies.addAll(movies);

      emit(
        SuggestLoaded(
          recommendations: List<MovieModel>.from(_movies),
          selectedMood: _selectedMood,
          selectedGenreId: _selectedGenreId,
        ),
      );
    } catch (e) {
      emit(SuggestError(e.toString()));
    }
  }

  Future<void> _onSurpriseMe(
    SurpriseMe event,
    Emitter<SuggestState> emit,
  ) async {
    add(const LoadSuggestions());
  }

  Future<void> _onSelectMood(
    SelectMood event,
    Emitter<SuggestState> emit,
  ) async {
    _selectedMood = event.mood;
    add(const LoadSuggestions());
  }

  Future<void> _onSelectGenre(
    SelectGenre event,
    Emitter<SuggestState> emit,
  ) async {
    _selectedGenreId = event.genreId;
    add(const LoadSuggestions());
  }

  Future<void> _onLoadMoreSuggestions(
    LoadMoreSuggestions event,
    Emitter<SuggestState> emit,
  ) async {
    if (_isLoadingMore || _hasReachedMax || state is! SuggestLoaded) return;

    _isLoadingMore = true;

    emit((state as SuggestLoaded).copyWith(isLoadingMore: true));

    try {
      final movies = await repository.getSuggestions(
        page: ++_page,
        mood: _selectedMood,
        genreId: _selectedGenreId,
      );

      if (movies.isEmpty) {
        _hasReachedMax = true;
      } else {
        _movies.addAll(movies);
      }

      emit(
        SuggestLoaded(
          recommendations: List<MovieModel>.from(_movies),
          selectedMood: _selectedMood,
          selectedGenreId: _selectedGenreId,
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      emit(SuggestError(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> _onRefreshSuggestions(
    RefreshSuggestions event,
    Emitter<SuggestState> emit,
  ) async {
    add(const LoadSuggestions());
  }
}
