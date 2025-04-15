part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

final class WatchlistMovieLoading extends WatchlistMovieState {}

final class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> movie;

  const WatchlistMovieLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class WatchlistMovieFailed extends WatchlistMovieState {
  final String error;

  const WatchlistMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
