part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> movie;

  const TopRatedMovieLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class TopRatedMovieFailed extends TopRatedMovieState {
  final String error;

  const TopRatedMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
