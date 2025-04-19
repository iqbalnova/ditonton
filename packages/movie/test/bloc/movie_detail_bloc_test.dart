import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import 'movie_detail_bloc_test.mocks.dart';

// Generate mocks for all the use cases
@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListMovieStatus: mockGetWatchlistStatus,
      saveMovieWatchlist: mockSaveWatchlist,
      removeMovieWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
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
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: const [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  test('initial state should be MovieDetailInitial', () {
    expect(movieDetailBloc.state, MovieDetailInitial());
  });

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Right(tMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(movieId: tId)),
      expect:
          () => [
            MovieDetailLoading(),
            MovieDetailLoaded(
              movieDetail: tMovieDetail,
              movieRecommendations: tMovies,
            ),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when getting movie detail fails',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(movieId: tId)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when getting recommendations fails',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Right(tMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(movieId: tId)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when an exception occurs during detail fetch',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenThrow(Exception('Test exception'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(movieId: tId)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Get Watchlist Status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, WatchlistStatusLoaded(true)] when movie is in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistMovieStatusEvent(movieId: tId)),
      expect: () => [MovieDetailLoading(), const WatchlistStatusLoaded(true)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, WatchlistStatusLoaded(false)] when movie is not in watchlist',
      build: () {
        when(
          mockGetWatchlistStatus.execute(tId),
        ).thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistMovieStatusEvent(movieId: tId)),
      expect: () => [MovieDetailLoading(), const WatchlistStatusLoaded(false)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when getting watchlist status throws exception',
      build: () {
        when(
          mockGetWatchlistStatus.execute(tId),
        ).thenThrow(Exception('Test exception'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistMovieStatusEvent(movieId: tId)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Save Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, WatchlistChangeSuccess, WatchlistStatusLoaded(true)] when successfully added to watchlist',
      build: () {
        when(
          mockSaveWatchlist.execute(tMovieDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(
          mockGetWatchlistStatus.execute(tMovieDetail.id),
        ).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const WatchlistChangeSuccess(message: 'Added to Watchlist'),
            const WatchlistStatusLoaded(true),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when adding to watchlist fails',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')),
        );
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Database Failure'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when add watchlist throws exception',
      build: () {
        when(
          mockSaveWatchlist.execute(tMovieDetail),
        ).thenThrow(Exception('Test exception'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Remove Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, WatchlistChangeSuccess, WatchlistStatusLoaded(false)] when successfully removed from watchlist',
      build: () {
        when(
          mockRemoveWatchlist.execute(tMovieDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(
          mockGetWatchlistStatus.execute(tMovieDetail.id),
        ).thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const WatchlistChangeSuccess(message: 'Removed from Watchlist'),
            const WatchlistStatusLoaded(false),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
        verify(mockGetWatchlistStatus.execute(tMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when removing from watchlist fails',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')),
        );
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Database Failure'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Failed] when remove watchlist throws exception',
      build: () {
        when(
          mockRemoveWatchlist.execute(tMovieDetail),
        ).thenThrow(Exception('Test exception'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistMovieEvent(movie: tMovieDetail)),
      expect:
          () => [
            MovieDetailLoading(),
            const MovieDetailFailed('Exception: Test exception'),
          ],
    );
  });
}
