import 'package:flutter_test/flutter_test.dart';
import 'package:series/domain/entities/season.dart';

void main() {
  const tSeason = Season(
    airDate: '2021-10-10',
    episodeCount: 10,
    id: 123,
    name: 'Season 1',
    overview: 'Overview of season 1',
    posterPath: '/poster.jpg',
    seasonNumber: 1,
    voteAverage: 8.5,
  );

  group('Season Entity', () {
    test('should support value comparison', () {
      const tSeason2 = Season(
        airDate: '2021-10-10',
        episodeCount: 10,
        id: 123,
        name: 'Season 1',
        overview: 'Overview of season 1',
        posterPath: '/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      expect(tSeason, equals(tSeason2));
    });

    test('props should contain all attributes', () {
      expect(tSeason.props, [
        '2021-10-10',
        10,
        123,
        'Season 1',
        'Overview of season 1',
        '/poster.jpg',
        1,
        8.5,
      ]);
    });
  });
}
