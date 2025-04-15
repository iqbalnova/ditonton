part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}

final class SearchMovieLoading extends SearchMovieState {}

final class SearchMovieLoaded extends SearchMovieState {
  final List<Movie> movie;

  const SearchMovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

final class SearchMovieFailed extends SearchMovieState {
  final String error;

  const SearchMovieFailed(this.error);

  @override
  List<Object> get props => [error];
}
