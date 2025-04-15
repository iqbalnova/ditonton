part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchWatchlistMovieEvent extends WatchlistMovieEvent {}
