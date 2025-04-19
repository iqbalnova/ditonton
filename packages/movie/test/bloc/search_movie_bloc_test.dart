import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(searchMovie: mockSearchMovies);
  });

  const testQuery = 'Spider-Man';
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

  test('initial state should be SearchMovieInitial', () {
    expect(bloc.state, SearchMovieInitial());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockSearchMovies.execute(testQuery),
      ).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchEvent(testQuery)),
    expect: () => [SearchMovieLoading(), SearchMovieLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery)).called(1);
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'emits [Loading, Failed] when getting data fails',
    build: () {
      when(
        mockSearchMovies.execute(testQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchEvent(testQuery)),
    expect:
        () => [SearchMovieLoading(), const SearchMovieFailed('Server Error')],
    verify: (_) {
      verify(mockSearchMovies.execute(testQuery)).called(1);
    },
  );
}
