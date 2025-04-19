import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetTopRatedSeries(mockRepository);
  });

  final tSeriesList = <Series>[];

  test('should get top rated series from repository', () async {
    when(
      mockRepository.getTopRatedSeries(),
    ).thenAnswer((_) async => Right(tSeriesList));

    final result = await usecase.execute();

    expect(result, Right(tSeriesList));
  });
}
