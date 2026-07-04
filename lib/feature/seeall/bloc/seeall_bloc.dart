import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_category.dart';
import 'package:movie_box/feature/home/repository/home_repository.dart';

part 'seeall_event.dart';
part 'seeall_state.dart';

class SeeAllBloc extends Bloc<SeeAllEvent, SeeAllState> {
  final HomeRepository repository;

  SeeAllBloc(this.repository) : super(SeeAllInitial()) {
    on<LoadSeeAllMoviesEvent>(_loadMovies);
    on<LoadMoreMoviesEvent>(_loadMore);
  }

  int page = 1;

  late MovieCategory category;

  final List<MovieModel> movies = [];

  Future<void> _loadMovies(
    LoadSeeAllMoviesEvent event,
    Emitter<SeeAllState> emit,
  ) async {
    emit(SeeAllLoading());
    category = event.category;
    page = 1;
    movies.clear();
    final response = await repository.getMovies(category, page: page);
    movies.addAll(response.results);
    emit(
      SeeAllLoaded(
        movies: List.from(movies),
        hasReachedMax: page >= response.totalPages,
      ),
    );
  }

  Future<void> _loadMore(
    LoadMoreMoviesEvent event,
    Emitter<SeeAllState> emit,
  ) async {
    if (state is! SeeAllLoaded) return;
    final current = state as SeeAllLoaded;
    if (current.isLoadingMore || current.hasReachedMax) return;
    emit(current.copyWith(isLoadingMore: true));
    final response = await repository.getMovies(category, page: page + 1);
    page++;
    movies.addAll(response.results);
    emit(
      current.copyWith(
        movies: List.from(movies),
        hasReachedMax: page >= response.totalPages,
        isLoadingMore: false,
      ),
    );
  }
}
