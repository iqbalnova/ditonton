import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/usecases/get_now_playing_series.dart';
import '../../../domain/usecases/get_popular_series.dart';
import '../../../domain/usecases/get_top_rated_series.dart';

part 'home_series_event.dart';
part 'home_series_state.dart';

class HomeSeriesBloc extends Bloc<HomeSeriesEvent, HomeSeriesState> {
  final GetNowPlayingSeries getNowPlayingSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  HomeSeriesBloc({
    required this.getNowPlayingSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  }) : super(HomeSeriesInitial()) {
    on<FetchNowPlayingSeriesEvent>(onFetchNowPlayingSeries);
    on<FetchPopularSeriesEvent>(onFetchPopularSeries);
    on<FetchTopRatedSeriesEvent>(onFetchTopRatedSeries);
  }

  Future<void> onFetchNowPlayingSeries(
    FetchNowPlayingSeriesEvent event,
    emit,
  ) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getNowPlayingSeries.execute();

      series.fold(
        (error) {
          emit(HomeSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(NowPlayingSeriesLoaded(nowPlayingSeries: seriesData));
        },
      );
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }

  Future<void> onFetchPopularSeries(FetchPopularSeriesEvent event, emit) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getPopularSeries.execute();

      series.fold(
        (error) {
          emit(HomeSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(PopularSeriesLoaded(popularSeries: seriesData));
        },
      );
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }

  Future<void> onFetchTopRatedSeries(
    FetchTopRatedSeriesEvent event,
    emit,
  ) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getTopRatedSeries.execute();

      series.fold(
        (error) {
          emit(HomeSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(TopRatedSeriesLoaded(topRatedSeries: seriesData));
        },
      );
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }
}
