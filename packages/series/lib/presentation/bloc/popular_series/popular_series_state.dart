part of 'popular_series_bloc.dart';

sealed class PopularSeriesState extends Equatable {
  const PopularSeriesState();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class PopularSeriesInitial extends PopularSeriesState {}

final class PopularSeriesLoading extends PopularSeriesState {}

final class PopularSeriesLoaded extends PopularSeriesState {
  final List<Series> series;

  const PopularSeriesLoaded({required this.series});

  @override
  List<Object> get props => [series];
}

final class PopularSeriesFailed extends PopularSeriesState {
  final String error;

  const PopularSeriesFailed({required this.error});

  @override
  List<Object> get props => [error];
}
