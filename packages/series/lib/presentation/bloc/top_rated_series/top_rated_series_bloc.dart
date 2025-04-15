import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_top_rated_series.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesBloc({required this.getTopRatedSeries})
    : super(TopRatedSeriesInitial()) {
    on<FetchTopRatedSeriesEvent>(onFetchTopRatedSeries);
  }

  Future<void> onFetchTopRatedSeries(
    FetchTopRatedSeriesEvent event,
    emit,
  ) async {
    try {
      emit(TopRatedSeriesLoading());

      final result = await getTopRatedSeries.execute();

      result.fold(
        (error) {
          emit(TopRatedSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(TopRatedSeriesLoaded(series: seriesData));
        },
      );
    } catch (e) {
      emit(TopRatedSeriesFailed(error: e.toString()));
    }
  }
}
