import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovie;

  PopularMovieBloc({required this.getPopularMovie})
    : super(PopularMovieInitial()) {
    on<FetchPopularMovieEvent>(onFetchPopularMovie);
  }

  Future<void> onFetchPopularMovie(FetchPopularMovieEvent event, emit) async {
    try {
      emit(PopularMovieLoading());

      final result = await getPopularMovie.execute();

      result.fold(
        (error) {
          emit(PopularMovieFailed(error: error.message));
        },
        (seriesData) {
          emit(PopularMovieLoaded(movie: seriesData));
        },
      );
    } catch (e) {
      emit(PopularMovieFailed(error: e.toString()));
    }
  }
}
