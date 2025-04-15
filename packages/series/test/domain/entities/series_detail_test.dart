import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series_detail.dart';

void main() {
  const tSeriesDetail = SeriesDetail(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genres: [Genre(id: 1, name: 'Drama')],
    id: 1,
    originalName: 'Original Series',
    overview: 'This is an overview.',
    posterPath: '/poster.jpg',
    firstAirDate: '2021-01-01',
    name: 'Series Name',
    voteAverage: 8.5,
    voteCount: 100,
    seasons: [
      Season(
        airDate: '2021-01-01',
        episodeCount: 10,
        id: 10,
        name: 'Season 1',
        overview: 'Overview Season 1',
        posterPath: '/poster1.jpg',
        seasonNumber: 1,
        voteAverage: 7.5,
      ),
    ],
  );

  group('SeriesDetail Entity', () {
    test('should support value equality', () {
      const other = SeriesDetail(
        adult: false,
        backdropPath: '/backdrop.jpg',
        genres: [Genre(id: 1, name: 'Drama')],
        id: 1,
        originalName: 'Original Series',
        overview: 'This is an overview.',
        posterPath: '/poster.jpg',
        firstAirDate: '2021-01-01',
        name: 'Series Name',
        voteAverage: 8.5,
        voteCount: 100,
        seasons: [
          Season(
            airDate: '2021-01-01',
            episodeCount: 10,
            id: 10,
            name: 'Season 1',
            overview: 'Overview Season 1',
            posterPath: '/poster1.jpg',
            seasonNumber: 1,
            voteAverage: 7.5,
          ),
        ],
      );

      expect(tSeriesDetail, equals(other));
    });
  });
}
