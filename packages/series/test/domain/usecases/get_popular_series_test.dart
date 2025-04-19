import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSeries usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetPopularSeries(mockRepository);
  });

  final tSeriesList = <Series>[];

  test('should get popular series from repository', () async {
    when(
      mockRepository.getPopularSeries(),
    ).thenAnswer((_) async => Right(tSeriesList));

    final result = await usecase.execute();

    expect(result, Right(tSeriesList));
  });
}
