import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_popular_series.dart';

part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;

  PopularSeriesBloc({required this.getPopularSeries})
    : super(PopularSeriesInitial()) {
    on<FetchPopularSeriesEvent>(onFetchPopularSeries);
  }

  Future<void> onFetchPopularSeries(FetchPopularSeriesEvent event, emit) async {
    try {
      emit(PopularSeriesLoading());

      final result = await getPopularSeries.execute();

      result.fold(
        (error) {
          emit(PopularSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(PopularSeriesLoaded(series: seriesData));
        },
      );
    } catch (e) {
      emit(PopularSeriesFailed(error: e.toString()));
    }
  }
}
