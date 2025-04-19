import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingSeries usecase;
  late MockSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockSeriesRepository();
    usecase = GetNowPlayingSeries(mockRepository);
  });

  final tSeriesList = <Series>[];

  test('should get now playing series from repository', () async {
    // arrange
    when(
      mockRepository.getNowPlayingSeries(),
    ).thenAnswer((_) async => Right(tSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeriesList));
  });
}
