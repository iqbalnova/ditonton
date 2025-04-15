import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/data/models/series_table.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

void main() {
  const tSeriesTable = SeriesTable(
    id: 1,
    name: 'Series Title',
    posterPath: '/path.jpg',
    overview: 'Series Overview',
  );

  final tSeriesDetail = SeriesDetail(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genres: const [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'Original Series Title',
    overview: 'Series Overview',
    posterPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    name: 'Series Title',
    voteAverage: 8.5,
    voteCount: 1200,
    seasons: const [
      Season(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 101,
        name: 'Season 1',
        overview: 'Overview of season 1',
        posterPath: '/season1.jpg',
        seasonNumber: 1,
        voteAverage: 8.0,
      ),
    ],
  );

  final tSeriesMap = {
    'id': 1,
    'name': 'Series Title',
    'posterPath': '/path.jpg',
    'overview': 'Series Overview',
  };

  group('SeriesTable', () {
    test('fromEntity should return valid SeriesTable', () {
      final result = SeriesTable.fromEntity(tSeriesDetail);
      expect(result, tSeriesTable);
    });

    test('toJson should return valid map', () {
      final result = tSeriesTable.toJson();
      expect(result, tSeriesMap);
    });

    test('fromMap should return valid SeriesTable', () {
      final result = SeriesTable.fromMap(tSeriesMap);
      expect(result, tSeriesTable);
    });

    test('toEntity should return valid Series entity', () {
      final result = tSeriesTable.toEntity();
      expect(
        result,
        Series.watchlist(
          id: 1,
          name: 'Series Title',
          overview: 'Series Overview',
          posterPath: '/path.jpg',
        ),
      );
    });
  });
}
