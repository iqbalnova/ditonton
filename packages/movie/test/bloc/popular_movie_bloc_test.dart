import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:core/common/failure.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMovieBloc(getPopularMovie: mockGetPopularMovies);
  });

  final testMovieList = <Movie>[
    Movie(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genreIds: [28, 12],
      id: 1,
      originalTitle: 'Popular Original',
      overview: 'A popular movie',
      popularity: 150.0,
      posterPath: '/poster.jpg',
      releaseDate: '2005-07-15',
      title: 'Popular Movie',
      video: false,
      voteAverage: 8.0,
      voteCount: 20000,
    ),
  ];

  test('initial state should be PopularMovieInitial', () {
    expect(bloc.state, PopularMovieInitial());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovieEvent()),
    expect:
        () => [PopularMovieLoading(), PopularMovieLoaded(movie: testMovieList)],
    verify: (_) {
      verify(mockGetPopularMovies.execute()).called(1);
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Failed] when getting data fails',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovieEvent()),
    expect:
        () => [
          PopularMovieLoading(),
          PopularMovieFailed(error: 'Server Error'),
        ],
    verify: (_) {
      verify(mockGetPopularMovies.execute()).called(1);
    },
  );
}
