import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/usecases/get_series_detail.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/entities/series_detail.dart';
import '../../../domain/usecases/get_series_recommendations.dart';
import '../../../domain/usecases/get_watchlist_series_status.dart';
import '../../../domain/usecases/remove_series_watchlist.dart';
import '../../../domain/usecases/save_series_watchlist.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveSeriesWatchlist saveSeriesWatchlist;
  final RemoveSeriesWatchlist removeSeriesWatchlist;

  SeriesDetailBloc({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListSeriesStatus,
    required this.saveSeriesWatchlist,
    required this.removeSeriesWatchlist,
  }) : super(SeriesDetailInitial()) {
    on<FetchSeriesDetailEvent>(onFetchSeriesDetail);
    on<SaveWatchlistSeriesEvent>(onSaveWatchlist);
    on<RemoveWatchlistSeriesEvent>(onRemoveWatchlist);
    on<GetWatchlistSeriesStatusEvent>(onGetWatchlistSeriesStatusEvent);
  }

  Future<void> onFetchSeriesDetail(FetchSeriesDetailEvent event, emit) async {
    emit(SeriesDetailLoading());
    try {
      final detailResult = await getSeriesDetail.execute(event.seriesId);
      final recommendationResult = await getSeriesRecommendations.execute(
        event.seriesId,
      );

      detailResult.fold(
        (failure) => emit(SeriesDetailFailed(failure.message)),
        (seriesDetail) {
          recommendationResult.fold(
            (failure) => emit(SeriesDetailFailed(failure.message)),
            (recommendations) {
              emit(
                SeriesDetailLoaded(
                  seriesDetail: seriesDetail,
                  seriesRecommendations: recommendations,
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onGetWatchlistSeriesStatusEvent(
    GetWatchlistSeriesStatusEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await getWatchListSeriesStatus.execute(event.seriesId);

      emit(WatchlistStatusLoaded(result));
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onSaveWatchlist(SaveWatchlistSeriesEvent event, emit) async {
    try {
      emit(SeriesDetailLoading());

      final result = await saveSeriesWatchlist.execute(event.serie);

      await result.fold(
        (error) {
          emit(SeriesDetailFailed(error.message));
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListSeriesStatus.execute(
            event.serie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onRemoveWatchlist(RemoveWatchlistSeriesEvent event, emit) async {
    try {
      emit(SeriesDetailLoading());

      final result = await removeSeriesWatchlist.execute(event.serie);

      await result.fold(
        (error) {
          emit(SeriesDetailFailed(error.message));
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListSeriesStatus.execute(
            event.serie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }
}
