part of 'popular_movie_bloc.dart';

sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class PopularMovieInitial extends PopularMovieState {}

final class PopularMovieLoading extends PopularMovieState {}

final class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> movie;

  const PopularMovieLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class PopularMovieFailed extends PopularMovieState {
  final String error;

  const PopularMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
