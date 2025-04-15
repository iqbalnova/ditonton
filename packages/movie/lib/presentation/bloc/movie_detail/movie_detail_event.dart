part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchMovieDetailEvent extends MovieDetailEvent {
  final int movieId;

  const FetchMovieDetailEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

final class SaveWatchlistMovieEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const SaveWatchlistMovieEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class RemoveWatchlistMovieEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovieEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class GetWatchlistMovieStatusEvent extends MovieDetailEvent {
  final int movieId;

  const GetWatchlistMovieStatusEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
