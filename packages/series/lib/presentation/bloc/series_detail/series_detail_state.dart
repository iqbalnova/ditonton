part of 'series_detail_bloc.dart';

sealed class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class SeriesDetailInitial extends SeriesDetailState {}

final class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailLoaded extends SeriesDetailState {
  final SeriesDetail seriesDetail;
  final List<Series> seriesRecommendations;

  const SeriesDetailLoaded({
    required this.seriesDetail,
    required this.seriesRecommendations,
  });

  @override
  List<Object> get props => [seriesDetail, seriesRecommendations];
}

final class SeriesRecommendationLoaded extends SeriesDetailState {
  final List<Series> recommendationSeries;

  const SeriesRecommendationLoaded({required this.recommendationSeries});

  @override
  List<Object> get props => [recommendationSeries];
}

final class WatchlistStatusLoaded extends SeriesDetailState {
  final bool isAddedWatchlist;

  const WatchlistStatusLoaded(this.isAddedWatchlist);

  @override
  List<Object> get props => [isAddedWatchlist];
}

final class WatchlistChangeSuccess extends SeriesDetailState {
  final String message;

  const WatchlistChangeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class SeriesDetailFailed extends SeriesDetailState {
  final String error;

  const SeriesDetailFailed(this.error);

  @override
  List<Object> get props => [error];
}
