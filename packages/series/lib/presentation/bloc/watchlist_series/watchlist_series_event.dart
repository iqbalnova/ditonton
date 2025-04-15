part of 'watchlist_series_bloc.dart';

sealed class WatchlistSeriesEvent extends Equatable {
  const WatchlistSeriesEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchWatchlistSeriesEvent extends WatchlistSeriesEvent {}
