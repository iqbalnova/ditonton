part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;

  const MovieDetailLoaded({
    required this.movieDetail,
    required this.movieRecommendations,
  });

  @override
  List<Object> get props => [movieDetail, movieRecommendations];
}

final class MovieRecommendationLoaded extends MovieDetailState {
  final List<Movie> recommendationMovie;

  const MovieRecommendationLoaded({required this.recommendationMovie});

  @override
  List<Object> get props => [recommendationMovie];
}

final class WatchlistStatusLoaded extends MovieDetailState {
  final bool isAddedWatchlist;

  const WatchlistStatusLoaded(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

final class WatchlistChangeSuccess extends MovieDetailState {
  final String message;

  const WatchlistChangeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class MovieDetailFailed extends MovieDetailState {
  final String error;

  const MovieDetailFailed(this.error);

  @override
  List<Object> get props => [error];
}
