import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'home_movie_event.dart';
part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies getNowPlayingMovie;
  final GetPopularMovies getPopularMovie;
  final GetTopRatedMovies getTopRatedMovie;

  HomeMovieBloc({
    required this.getNowPlayingMovie,
    required this.getPopularMovie,
    required this.getTopRatedMovie,
  }) : super(HomeMovieInitial()) {
    on<FetchNowPlayingMovieEvent>(onFetchNowPlayingMovie);
    on<FetchPopularMovieEvent>(onFetchPopularMovie);
    on<FetchTopRatedMovieEvent>(onFetchTopRatedMovie);
  }

  Future<void> onFetchNowPlayingMovie(
    FetchNowPlayingMovieEvent event,
    emit,
  ) async {
    try {
      emit(HomeMovieLoading());

      final movie = await getNowPlayingMovie.execute();

      movie.fold(
        (error) {
          emit(HomeMovieFailed(error: error.message));
        },
        (movieData) {
          emit(NowPlayingMovieLoaded(nowPlayingMovie: movieData));
        },
      );
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }

  Future<void> onFetchPopularMovie(FetchPopularMovieEvent event, emit) async {
    try {
      emit(HomeMovieLoading());

      final movie = await getPopularMovie.execute();

      movie.fold(
        (error) {
          emit(HomeMovieFailed(error: error.message));
        },
        (movieData) {
          emit(PopularMovieLoaded(popularMovie: movieData));
        },
      );
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }

  Future<void> onFetchTopRatedMovie(FetchTopRatedMovieEvent event, emit) async {
    try {
      emit(HomeMovieLoading());

      final movie = await getTopRatedMovie.execute();

      movie.fold(
        (error) {
          emit(HomeMovieFailed(error: error.message));
        },
        (movieData) {
          emit(TopRatedMovieLoaded(topRatedMovie: movieData));
        },
      );
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }
}
