import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovie;

  SearchMovieBloc({required this.searchMovie}) : super(SearchMovieInitial()) {
    on<SearchEvent>(onSearchMovie);
  }

  Future<void> onSearchMovie(SearchEvent event, emit) async {
    try {
      emit(SearchMovieLoading());

      final result = await searchMovie.execute(event.query);

      result.fold(
        (error) {
          emit(SearchMovieFailed(error.message));
        },
        (movieData) {
          emit(SearchMovieLoaded(movieData));
        },
      );
    } catch (e) {
      emit(SearchMovieFailed(e.toString()));
    }
  }
}
