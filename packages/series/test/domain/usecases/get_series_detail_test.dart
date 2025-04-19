import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockRepository);
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

  test('should get series detail from repository', () async {
    when(
      mockRepository.getSeriesDetail(tId),
    ).thenAnswer((_) async => Right(tSeriesDetail));

    final result = await usecase.execute(tId);

    expect(result, Right(tSeriesDetail));
  });
}
