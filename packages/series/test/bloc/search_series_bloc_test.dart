import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';

import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc bloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    bloc = SearchSeriesBloc(searchSeries: mockSearchSeries);
  });

  const testQuery = 'Breaking Bad';
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

  test('initial state should be SearchSeriesInitial', () {
    expect(bloc.state, SearchSeriesInitial());
  });

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockSearchSeries.execute(testQuery),
      ).thenAnswer((_) async => Right(testSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchEvent(testQuery)),
    expect: () => [SearchSeriesLoading(), SearchSeriesLoaded(testSeriesList)],
    verify: (bloc) {
      verify(mockSearchSeries.execute(testQuery)).called(1);
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'emits [Loading, Failed] when getting data fails',
    build: () {
      when(
        mockSearchSeries.execute(testQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchEvent(testQuery)),
    expect:
        () => [SearchSeriesLoading(), const SearchSeriesFailed('Server Error')],
    verify: (_) {
      verify(mockSearchSeries.execute(testQuery)).called(1);
    },
  );
}
