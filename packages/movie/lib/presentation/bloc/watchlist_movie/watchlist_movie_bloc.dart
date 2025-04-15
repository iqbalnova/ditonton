import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovie;

  WatchlistMovieBloc({required this.getWatchlistMovie})
    : super(WatchlistMovieInitial()) {
    on<FetchWatchlistMovieEvent>(onFetchWatchlistMovie);
  }

  Future<void> onFetchWatchlistMovie(
    FetchWatchlistMovieEvent event,
    emit,
  ) async {
    try {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovie.execute();

      result.fold(
        (error) {
          emit(WatchlistMovieFailed(error: error.message));
        },
        (movieData) {
          emit(WatchlistMovieLoaded(movie: movieData));
        },
      );
    } catch (e) {
      emit(WatchlistMovieFailed(error: e.toString()));
    }
  }
}
