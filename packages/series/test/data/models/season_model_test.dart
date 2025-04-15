import 'package:flutter_test/flutter_test.dart';
import 'package:series/data/models/season_model.dart';
import 'package:series/domain/entities/season.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: '2021-01-01',
    episodeCount: 10,
    id: 100,
    name: 'Season 1',
    overview: 'Overview of season 1',
    posterPath: '/poster1.jpg',
    seasonNumber: 1,
    voteAverage: 8.0,
  );

  final tSeasonJson = {
    "air_date": "2021-01-01",
    "episode_count": 10,
    "id": 100,
    "name": "Season 1",
    "overview": "Overview of season 1",
    "poster_path": "/poster1.jpg",
    "season_number": 1,
    "vote_average": 8.0,
  };

  group('SeasonModel', () {
    test('fromJson should return valid model', () {
      final result = SeasonModel.fromJson(tSeasonJson);

      expect(result, equals(tSeasonModel));
    });

    test('toJson should return a valid map', () {
      final result = tSeasonModel.toJson();

      expect(result, equals(tSeasonJson));
    });

    test('toEntity should return a valid Season entity', () {
      final result = tSeasonModel.toEntity();

      expect(
        result,
        equals(
          const Season(
            airDate: '2021-01-01',
            episodeCount: 10,
            id: 100,
            name: 'Season 1',
            overview: 'Overview of season 1',
            posterPath: '/poster1.jpg',
            seasonNumber: 1,
            voteAverage: 8.0,
          ),
        ),
      );
    });
  });
}
