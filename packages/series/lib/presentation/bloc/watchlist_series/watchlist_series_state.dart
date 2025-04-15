part of 'watchlist_series_bloc.dart';

sealed class WatchlistSeriesState extends Equatable {
  const WatchlistSeriesState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class WatchlistSeriesInitial extends WatchlistSeriesState {}

final class WatchlistSeriesLoading extends WatchlistSeriesState {}

final class WatchlistSeriesLoaded extends WatchlistSeriesState {
  final List<Series> series;

  const WatchlistSeriesLoaded({required this.series});

  @override
  List<Object> get props => [series];
}

final class WatchlistSeriesFailed extends WatchlistSeriesState {
  final String error;

  const WatchlistSeriesFailed({required this.error});

  @override
  List<Object> get props => [error];
}
