import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:core/common/failure.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(getTopRatedMovie: mockGetTopRatedMovies);
  });

  final testMovieList = <Movie>[
    Movie(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genreIds: [28, 12],
      id: 1,
      originalTitle: 'Spider-Man Original',
      overview: 'A superhero movie',
      popularity: 100.0,
      posterPath: '/poster.jpg',
      releaseDate: '2002-05-03',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.5,
      voteCount: 12000,
    ),
  ];

  test('initial state should be TopRatedMovieInitial', () {
    expect(bloc.state, TopRatedMovieInitial());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
    expect:
        () => [
          TopRatedMovieLoading(),
          TopRatedMovieLoaded(movie: testMovieList),
        ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute()).called(1);
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [Loading, Failed] when getting data fails',
    build: () {
      when(
        mockGetTopRatedMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
    expect:
        () => [
          TopRatedMovieLoading(),
          TopRatedMovieFailed(error: 'Server Error'),
        ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute()).called(1);
    },
  );
}
