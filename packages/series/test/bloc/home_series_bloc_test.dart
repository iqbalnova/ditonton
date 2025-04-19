import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/bloc/home_series/home_series_bloc.dart';

import 'home_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late HomeSeriesBloc homeSeriesBloc;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    homeSeriesBloc = HomeSeriesBloc(
      getNowPlayingSeries: mockGetNowPlayingSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    );
  });

  final tSeriesList = <Series>[
    Series(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      originalName: 'Breaking Bad',
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      name: 'Breaking Bad',
      voteAverage: 7.2,
      voteCount: 13507,
    ),
  ];

  test('initial state should be HomeSeriesInitial', () {
    expect(homeSeriesBloc.state, HomeSeriesInitial());
  });

  group('Now Playing Series', () {
    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, NowPlayingSeriesLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetNowPlayingSeries.execute(),
        ).thenAnswer((_) async => Right(tSeriesList));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            NowPlayingSeriesLoaded(nowPlayingSeries: tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get now playing seriess is unsuccessful',
      build: () {
        when(
          mockGetNowPlayingSeries.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get now playing seriess throws exception',
      build: () {
        when(
          mockGetNowPlayingSeries.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );
  });

  group('Popular Series', () {
    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, PopularSeriesLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetPopularSeries.execute(),
        ).thenAnswer((_) async => Right(tSeriesList));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            PopularSeriesLoaded(popularSeries: tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get popular seriess is unsuccessful',
      build: () {
        when(
          mockGetPopularSeries.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get popular seriess throws exception',
      build: () {
        when(
          mockGetPopularSeries.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });

  group('Top Rated Series', () {
    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, TopRatedSeriesLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetTopRatedSeries.execute(),
        ).thenAnswer((_) async => Right(tSeriesList));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            TopRatedSeriesLoaded(topRatedSeries: tSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get top rated seriess is unsuccessful',
      build: () {
        when(
          mockGetTopRatedSeries.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<HomeSeriesBloc, HomeSeriesState>(
      'Should emit [Loading, HomeSeriesFailed] when get top rated seriess throws exception',
      build: () {
        when(
          mockGetTopRatedSeries.execute(),
        ).thenThrow(Exception('Test exception'));
        return homeSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect:
          () => [
            HomeSeriesLoading(),
            const HomeSeriesFailed(error: 'Exception: Test exception'),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });
}
