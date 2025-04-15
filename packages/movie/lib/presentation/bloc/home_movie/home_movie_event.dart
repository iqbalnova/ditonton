part of 'home_movie_bloc.dart';

sealed class HomeMovieEvent extends Equatable {
  const HomeMovieEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchNowPlayingMovieEvent extends HomeMovieEvent {}

final class FetchPopularMovieEvent extends HomeMovieEvent {}

final class FetchTopRatedMovieEvent extends HomeMovieEvent {}
