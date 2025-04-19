import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesRecommendations usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetSeriesRecommendations(mockRepository);
  });

  const tId = 1;
  final tSeriesList = <Series>[];

  test('should get recommendations from repository', () async {
    when(
      mockRepository.getSeriesRecommendations(tId),
    ).thenAnswer((_) async => Right(tSeriesList));

    final result = await usecase.execute(tId);

    expect(result, Right(tSeriesList));
  });
}
