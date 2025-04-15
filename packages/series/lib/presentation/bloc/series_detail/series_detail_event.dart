part of 'series_detail_bloc.dart';

sealed class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchSeriesDetailEvent extends SeriesDetailEvent {
  final int seriesId;

  const FetchSeriesDetailEvent({required this.seriesId});

  @override
  List<Object> get props => [seriesId];
}

final class SaveWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail serie;

  const SaveWatchlistSeriesEvent({required this.serie});

  @override
  List<Object> get props => [serie];
}

final class RemoveWatchlistSeriesEvent extends SeriesDetailEvent {
  final SeriesDetail serie;

  const RemoveWatchlistSeriesEvent({required this.serie});

  @override
  List<Object> get props => [serie];
}

final class GetWatchlistSeriesStatusEvent extends SeriesDetailEvent {
  final int seriesId;

  const GetWatchlistSeriesStatusEvent({required this.seriesId});

  @override
  List<Object> get props => [seriesId];
}
