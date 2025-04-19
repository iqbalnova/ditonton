import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc.dart';

import 'home_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late HomeMovieBloc homeMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    homeMovieBloc = HomeMovieBloc(
      getNowPlayingMovie: mockGetNowPlayingMovies,
      getPopularMovie: mockGetPopularMovies,
      getTopRatedMovie: mockGetTopRatedMovies,
    );
  });

  final tMovieList = <Movie>[
    Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    ),
  ];

  test('initial state should be HomeMovieInitial', () {
    expect(homeMovieBloc.state, HomeMovieInitial());
  });

  group('Now Playing Movies', () {
    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, NowPlayingMovieLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            NowPlayingMovieLoaded(nowPlayingMovie: tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get now playing movies is unsuccessful',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get now playing movies throws exception',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('Popular Movies', () {
    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, PopularMovieLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetPopularMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            PopularMovieLoaded(popularMovie: tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get popular movies is unsuccessful',
      build: () {
        when(
          mockGetPopularMovies.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get popular movies throws exception',
      build: () {
        when(
          mockGetPopularMovies.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('Top Rated Movies', () {
    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, TopRatedMovieLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            TopRatedMovieLoaded(topRatedMovie: tMovieList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get top rated movies is unsuccessful',
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<HomeMovieBloc, HomeMovieState>(
      'Should emit [Loading, HomeMovieFailed] when get top rated movies throws exception',
      build: () {
        when(
          mockGetTopRatedMovies.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
      expect:
          () => [
            HomeMovieLoading(),
            const HomeMovieFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
