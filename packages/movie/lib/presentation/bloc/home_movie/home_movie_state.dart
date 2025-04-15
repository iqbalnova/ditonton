part of 'home_movie_bloc.dart';

sealed class HomeMovieState extends Equatable {
  const HomeMovieState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class HomeMovieInitial extends HomeMovieState {}

final class HomeMovieLoading extends HomeMovieState {}

final class NowPlayingMovieLoaded extends HomeMovieState {
  final List<Movie> nowPlayingMovie;

  const NowPlayingMovieLoaded({required this.nowPlayingMovie});

  @override
  List<Object> get props => [nowPlayingMovie];
}

final class PopularMovieLoaded extends HomeMovieState {
  final List<Movie> popularMovie;

  const PopularMovieLoaded({required this.popularMovie});

  @override
  List<Object> get props => [popularMovie];
}

final class TopRatedMovieLoaded extends HomeMovieState {
  final List<Movie> topRatedMovie;

  const TopRatedMovieLoaded({required this.topRatedMovie});

  @override
  List<Object> get props => [topRatedMovie];
}

final class HomeMovieFailed extends HomeMovieState {
  final String error;

  const HomeMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
