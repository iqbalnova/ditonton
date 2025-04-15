import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListMovieStatus;
  final SaveWatchlist saveMovieWatchlist;
  final RemoveWatchlist removeMovieWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListMovieStatus,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
  }) : super(MovieDetailInitial()) {
    on<FetchMovieDetailEvent>(onFetchMovieDetail);
    on<SaveWatchlistMovieEvent>(onSaveWatchlist);
    on<RemoveWatchlistMovieEvent>(onRemoveWatchlist);
    on<GetWatchlistMovieStatusEvent>(onGetWatchlistMovieStatusEvent);
  }

  Future<void> onFetchMovieDetail(FetchMovieDetailEvent event, emit) async {
    emit(MovieDetailLoading());
    try {
      final detailResult = await getMovieDetail.execute(event.movieId);
      final recommendationResult = await getMovieRecommendations.execute(
        event.movieId,
      );

      detailResult.fold((failure) => emit(MovieDetailFailed(failure.message)), (
        movieDetail,
      ) {
        recommendationResult.fold(
          (failure) => emit(MovieDetailFailed(failure.message)),
          (recommendations) {
            emit(
              MovieDetailLoaded(
                movieDetail: movieDetail,
                movieRecommendations: recommendations,
              ),
            );
          },
        );
      });
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onGetWatchlistMovieStatusEvent(
    GetWatchlistMovieStatusEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await getWatchListMovieStatus.execute(event.movieId);

      emit(WatchlistStatusLoaded(result));
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onSaveWatchlist(SaveWatchlistMovieEvent event, emit) async {
    try {
      emit(MovieDetailLoading());

      final result = await saveMovieWatchlist.execute(event.movie);

      await result.fold(
        (error) {
          emit(MovieDetailFailed(error.message));
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListMovieStatus.execute(
            event.movie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onRemoveWatchlist(RemoveWatchlistMovieEvent event, emit) async {
    try {
      emit(MovieDetailLoading());

      final result = await removeMovieWatchlist.execute(event.movie);

      await result.fold(
        (error) {
          emit(MovieDetailFailed(error.message));
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListMovieStatus.execute(
            event.movie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }
}
