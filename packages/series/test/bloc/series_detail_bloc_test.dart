import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_series_watchlist.dart';
import 'package:series/domain/usecases/save_series_watchlist.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';

import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListSeriesStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListSeriesStatus mockGetWatchlistStatus;
  late MockSaveSeriesWatchlist mockSaveWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveWatchlist;
  late SeriesDetailBloc seriesDetailBloc;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListSeriesStatus();
    mockSaveWatchlist = MockSaveSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveSeriesWatchlist();

    seriesDetailBloc = SeriesDetailBloc(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListSeriesStatus: mockGetWatchlistStatus,
      saveSeriesWatchlist: mockSaveWatchlist,
      removeSeriesWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tSeriesDetail = SeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    seasons: const [
      Season(
        airDate: "2010-12-05",
        episodeCount: 272,
        id: 3627,
        name: "Specials",
        overview: "",
        posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
        seasonNumber: 0,
        voteAverage: 0,
      ),
    ],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2002-05-01',
  );

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

  test('initial state should be SeriesDetailInitial', () {
    expect(seriesDetailBloc.state, SeriesDetailInitial());
  });

  group('Get Series Detail', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(
          mockGetSeriesDetail.execute(tId),
        ).thenAnswer((_) async => Right(tSeriesDetail));
        when(
          mockGetSeriesRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tSeriesList));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(seriesId: tId)),
      expect:
          () => [
            SeriesDetailLoading(),
            SeriesDetailLoaded(
              seriesDetail: tSeriesDetail,
              seriesRecommendations: tSeriesList,
            ),
          ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
        verify(mockGetSeriesRecommendations.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when getting series detail fails',
      build: () {
        when(
          mockGetSeriesDetail.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(
          mockGetSeriesRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tSeriesList));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(seriesId: tId)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when getting recommendations fails',
      build: () {
        when(
          mockGetSeriesDetail.execute(tId),
        ).thenAnswer((_) async => Right(tSeriesDetail));
        when(
          mockGetSeriesRecommendations.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(seriesId: tId)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetSeriesDetail.execute(tId));
        verify(mockGetSeriesRecommendations.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when an exception occurs during detail fetch',
      build: () {
        when(
          mockGetSeriesDetail.execute(tId),
        ).thenThrow(Exception('Test exception'));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(seriesId: tId)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Get Watchlist Status', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, WatchlistStatusLoaded(true)] when series is in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return seriesDetailBloc;
      },
      act:
          (bloc) =>
              bloc.add(const GetWatchlistSeriesStatusEvent(seriesId: tId)),
      expect: () => [SeriesDetailLoading(), const WatchlistStatusLoaded(true)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, WatchlistStatusLoaded(false)] when series is not in watchlist',
      build: () {
        when(
          mockGetWatchlistStatus.execute(tId),
        ).thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act:
          (bloc) =>
              bloc.add(const GetWatchlistSeriesStatusEvent(seriesId: tId)),
      expect: () => [SeriesDetailLoading(), const WatchlistStatusLoaded(false)],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when getting watchlist status throws exception',
      build: () {
        when(
          mockGetWatchlistStatus.execute(tId),
        ).thenThrow(Exception('Test exception'));
        return seriesDetailBloc;
      },
      act:
          (bloc) =>
              bloc.add(const GetWatchlistSeriesStatusEvent(seriesId: tId)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Save Watchlist', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, WatchlistChangeSuccess, WatchlistStatusLoaded(true)] when successfully added to watchlist',
      build: () {
        when(
          mockSaveWatchlist.execute(tSeriesDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(
          mockGetWatchlistStatus.execute(tSeriesDetail.id),
        ).thenAnswer((_) async => true);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const WatchlistChangeSuccess(message: 'Added to Watchlist'),
            const WatchlistStatusLoaded(true),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(tSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tSeriesDetail.id));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when adding to watchlist fails',
      build: () {
        when(mockSaveWatchlist.execute(tSeriesDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')),
        );
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Database Failure'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(tSeriesDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when add watchlist throws exception',
      build: () {
        when(
          mockSaveWatchlist.execute(tSeriesDetail),
        ).thenThrow(Exception('Test exception'));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Exception: Test exception'),
          ],
    );
  });

  group('Remove Watchlist', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, WatchlistChangeSuccess, WatchlistStatusLoaded(false)] when successfully removed from watchlist',
      build: () {
        when(
          mockRemoveWatchlist.execute(tSeriesDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(
          mockGetWatchlistStatus.execute(tSeriesDetail.id),
        ).thenAnswer((_) async => false);
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const WatchlistChangeSuccess(message: 'Removed from Watchlist'),
            const WatchlistStatusLoaded(false),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(tSeriesDetail));
        verify(mockGetWatchlistStatus.execute(tSeriesDetail.id));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when removing from watchlist fails',
      build: () {
        when(mockRemoveWatchlist.execute(tSeriesDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')),
        );
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Database Failure'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(tSeriesDetail));
      },
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'Should emit [Loading, Failed] when remove watchlist throws exception',
      build: () {
        when(
          mockRemoveWatchlist.execute(tSeriesDetail),
        ).thenThrow(Exception('Test exception'));
        return seriesDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistSeriesEvent(serie: tSeriesDetail)),
      expect:
          () => [
            SeriesDetailLoading(),
            const SeriesDetailFailed('Exception: Test exception'),
          ],
    );
  });
}
