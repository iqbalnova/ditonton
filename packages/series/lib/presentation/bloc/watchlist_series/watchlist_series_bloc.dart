import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_watchlist_series.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries getWatchlistSeries;

  WatchlistSeriesBloc({required this.getWatchlistSeries})
    : super(WatchlistSeriesInitial()) {
    on<FetchWatchlistSeriesEvent>(onFetchWatchlistSeries);
  }

  Future<void> onFetchWatchlistSeries(
    FetchWatchlistSeriesEvent event,
    emit,
  ) async {
    try {
      emit(WatchlistSeriesLoading());

      final result = await getWatchlistSeries.execute();

      result.fold(
        (error) {
          emit(WatchlistSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(WatchlistSeriesLoaded(series: seriesData));
        },
      );
    } catch (e) {
      emit(WatchlistSeriesFailed(error: e.toString()));
    }
  }
}
