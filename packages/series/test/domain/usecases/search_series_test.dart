import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/search_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SearchSeries(mockSeriesRepository);
  });

  final tSeries = Series(
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
  );

  final tSeriesList = <Series>[tSeries];
  const tQuery = 'Breaking Bad';

  test(
    'should get list of series from the repository when execute is called',
    () async {
      // arrange
      when(
        mockSeriesRepository.searchSeries(tQuery),
      ).thenAnswer((_) async => Right(tSeriesList));

      // act
      final result = await usecase.execute(tQuery);

      // assert
      expect(result, Right(tSeriesList));
      verify(mockSeriesRepository.searchSeries(tQuery));
      verifyNoMoreInteractions(mockSeriesRepository);
    },
  );

  test('should return failure when repository fails', () async {
    // arrange
    when(
      mockSeriesRepository.searchSeries(tQuery),
    ).thenAnswer((_) async => Left(ServerFailure('Server error')));

    // act
    final result = await usecase.execute(tQuery);

    // assert
    expect(result, Left(ServerFailure('Server error')));
    verify(mockSeriesRepository.searchSeries(tQuery));
    verifyNoMoreInteractions(mockSeriesRepository);
  });
}
