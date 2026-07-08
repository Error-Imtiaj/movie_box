import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/favourite/repository/favourite_repository.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc(this._repository) : super(const FavouriteInitial()) {
    on<LoadFavourites>(_onLoadFavourites);
    on<AddFavourite>(_onAddFavourite);
    on<RemoveFavourite>(_onRemoveFavourite);
    on<ToggleFavourite>(_onToggleFavourite);
    on<ClearFavourites>(_onClearFavourites);
  }

  final FavouriteRepository _repository;

  Future<void> _onLoadFavourites(
    LoadFavourites event,
    Emitter<FavouriteState> emit,
  ) async {
    emit(const FavouriteLoading());

    try {
      final movies = await _repository.getFavouriteMovies();
      emit(FavouriteLoaded(movies));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> _onAddFavourite(
    AddFavourite event,
    Emitter<FavouriteState> emit,
  ) async {
    await _repository.addToFavourite(event.movie);
    add(const LoadFavourites());
  }

  Future<void> _onRemoveFavourite(
    RemoveFavourite event,
    Emitter<FavouriteState> emit,
  ) async {
    await _repository.removeFromFavourite(event.movieId);
    add(const LoadFavourites());
  }

  Future<void> _onToggleFavourite(
    ToggleFavourite event,
    Emitter<FavouriteState> emit,
  ) async {
    await _repository.toggleFavourite(event.movie);
    add(const LoadFavourites());
  }

  Future<void> _onClearFavourites(
    ClearFavourites event,
    Emitter<FavouriteState> emit,
  ) async {
    await _repository.clearFavourites();
    add(const LoadFavourites());
  }
}
