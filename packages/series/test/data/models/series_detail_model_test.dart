import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/data/models/season_model.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series_detail.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: 'Action');
  const tSeasonModel = SeasonModel(
    airDate: '2022-01-01',
    episodeCount: 10,
    id: 100,
    name: 'Season 1',
    overview: 'Season overview',
    posterPath: '/season.jpg',
    seasonNumber: 1,
    voteAverage: 8.0,
  );

  const tSeriesDetailModel = SeriesDetailModel(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genres: [tGenreModel],
    homepage: 'https://homepage.com',
    id: 1,
    imdbId: 'tt123456',
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 100.0,
    posterPath: '/poster.jpg',
    firstAirDate: '2022-01-01',
    status: 'Returning Series',
    tagline: 'Some tagline',
    name: 'Series Name',
    voteAverage: 8.5,
    voteCount: 1000,
    seasons: [tSeasonModel],
  );

  final tSeriesDetailJson = {
    "adult": false,
    "backdrop_path": "/backdrop.jpg",
    "genres": [
      {"id": 1, "name": "Action"},
    ],
    "homepage": "https://homepage.com",
    "id": 1,
    "imdb_id": "tt123456",
    "original_language": "en",
    "original_name": "Original Name",
    "overview": "Overview",
    "popularity": 100.0,
    "poster_path": "/poster.jpg",
    "first_air_date": "2022-01-01",
    "status": "Returning Series",
    "tagline": "Some tagline",
    "name": "Series Name",
    "vote_average": 8.5,
    "vote_count": 1000,
    "seasons": [
      {
        "air_date": "2022-01-01",
        "episode_count": 10,
        "id": 100,
        "name": "Season 1",
        "overview": "Season overview",
        "poster_path": "/season.jpg",
        "season_number": 1,
        "vote_average": 8.0,
      },
    ],
  };

  group('SeriesDetailModel', () {
    test('should return valid model from JSON', () {
      final result = SeriesDetailModel.fromJson(tSeriesDetailJson);
      expect(result, tSeriesDetailModel);
    });

    test('should return JSON map from model', () {
      final result = tSeriesDetailModel.toJson();
      expect(result, tSeriesDetailJson);
    });

    test('should convert to SeriesDetail entity', () {
      final result = tSeriesDetailModel.toEntity();
      expect(
        result,
        SeriesDetail(
          adult: false,
          backdropPath: '/backdrop.jpg',
          genres: const [Genre(id: 1, name: 'Action')],
          seasons: const [
            Season(
              airDate: '2022-01-01',
              episodeCount: 10,
              id: 100,
              name: 'Season 1',
              overview: 'Season overview',
              posterPath: '/season.jpg',
              seasonNumber: 1,
              voteAverage: 8.0,
            ),
          ],
          id: 1,
          originalName: 'Original Name',
          overview: 'Overview',
          posterPath: '/poster.jpg',
          firstAirDate: '2022-01-01',
          name: 'Series Name',
          voteAverage: 8.5,
          voteCount: 1000,
        ),
      );
    });
  });
}
