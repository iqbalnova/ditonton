import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/remove_series_watchlist.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveSeriesWatchlist usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = RemoveSeriesWatchlist(mockRepository);
  });

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

  test(
    'should return success message when removing from watchlist succeeds',
    () async {
      when(
        mockRepository.removeWatchlist(tSeriesDetail),
      ).thenAnswer((_) async => const Right('Removed from Watchlist'));

      final result = await usecase.execute(tSeriesDetail);

      expect(result, const Right('Removed from Watchlist'));
    },
  );

  test('should return failure when removing from watchlist fails', () async {
    when(
      mockRepository.removeWatchlist(tSeriesDetail),
    ).thenAnswer((_) async => const Left(DatabaseFailure('Database Error')));

    final result = await usecase.execute(tSeriesDetail);

    expect(result, const Left(DatabaseFailure('Database Error')));
  });
}
