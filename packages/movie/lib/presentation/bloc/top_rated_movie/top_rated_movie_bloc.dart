import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovie;

  TopRatedMovieBloc({required this.getTopRatedMovie})
    : super(TopRatedMovieInitial()) {
    on<FetchTopRatedMovieEvent>(onFetchTopRatedMovie);
  }

  Future<void> onFetchTopRatedMovie(FetchTopRatedMovieEvent event, emit) async {
    try {
      emit(TopRatedMovieLoading());

      final result = await getTopRatedMovie.execute();

      result.fold(
        (error) {
          emit(TopRatedMovieFailed(error: error.message));
        },
        (movieData) {
          emit(TopRatedMovieLoaded(movie: movieData));
        },
      );
    } catch (e) {
      emit(TopRatedMovieFailed(error: e.toString()));
    }
  }
}
