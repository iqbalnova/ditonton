import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/series_model.dart';
import 'package:series/domain/entities/series.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-01-01",
    name: "Name",
    voteAverage: 8.5,
    voteCount: 123,
  );

  final tSeries = Series(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-01-01",
    name: "Name",
    voteAverage: 8.5,
    voteCount: 123,
  );

  test('should be a subclass of Series entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
