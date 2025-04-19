import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/common/failure.dart';

import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesBloc bloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    bloc = TopRatedSeriesBloc(getTopRatedSeries: mockGetTopRatedSeries);
  });

  final testSeriesList = <Series>[
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

  test('initial state should be TopRatedSeriesInitial', () {
    expect(bloc.state, TopRatedSeriesInitial());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetTopRatedSeries.execute(),
      ).thenAnswer((_) async => Right(testSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
    expect:
        () => [
          TopRatedSeriesLoading(),
          TopRatedSeriesLoaded(series: testSeriesList),
        ],
    verify: (_) {
      verify(mockGetTopRatedSeries.execute()).called(1);
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'emits [Loading, Failed] when getting data fails',
    build: () {
      when(
        mockGetTopRatedSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
    expect:
        () => [
          TopRatedSeriesLoading(),
          TopRatedSeriesFailed(error: 'Server Error'),
        ],
    verify: (_) {
      verify(mockGetTopRatedSeries.execute()).called(1);
    },
  );
}
