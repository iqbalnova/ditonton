import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/common/failure.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetWatchlistSeries(mockRepository);
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

  test('should get list of series from repository', () async {
    when(
      mockRepository.getWatchlistSeries(),
    ).thenAnswer((_) async => Right(tSeriesList));

    final result = await usecase.execute();

    expect(result, Right(tSeriesList));
  });

  test('should return failure when getting watchlist fails', () async {
    when(
      mockRepository.getWatchlistSeries(),
    ).thenAnswer((_) async => const Left(DatabaseFailure('Database Error')));

    final result = await usecase.execute();

    expect(result, const Left(DatabaseFailure('Database Error')));
  });
}
