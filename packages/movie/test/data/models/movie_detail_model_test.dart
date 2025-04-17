import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  final testMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: '/backdrop.jpg',
    budget: 100000000,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'https://example.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Movie overview',
    popularity: 100.5,
    posterPath: '/poster.jpg',
    releaseDate: '2020-01-01',
    revenue: 500000000,
    runtime: 120,
    status: 'Released',
    tagline: 'This is a tagline',
    title: 'Movie Title',
    video: false,
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final testJson = {
    "adult": false,
    "backdrop_path": "/backdrop.jpg",
    "budget": 100000000,
    "genres": [
      {"id": 1, "name": "Action"},
    ],
    "homepage": "https://example.com",
    "id": 1,
    "imdb_id": "tt1234567",
    "original_language": "en",
    "original_title": "Original Title",
    "overview": "Movie overview",
    "popularity": 100.5,
    "poster_path": "/poster.jpg",
    "release_date": "2020-01-01",
    "revenue": 500000000,
    "runtime": 120,
    "status": "Released",
    "tagline": "This is a tagline",
    "title": "Movie Title",
    "video": false,
    "vote_average": 8.5,
    "vote_count": 1000,
  };

  test('should return valid model from JSON', () {
    final result = MovieDetailResponse.fromJson(testJson);
    expect(result, testMovieDetailResponse);
  });

  test('should return JSON map from model', () {
    final result = testMovieDetailResponse.toJson();
    expect(result, testJson);
  });

  test('should convert to MovieDetail entity', () {
    final result = testMovieDetailResponse.toEntity();
    expect(
      result,
      isA<MovieDetail>()
          .having((m) => m.id, 'id', 1)
          .having((m) => m.title, 'title', 'Movie Title')
          .having((m) => m.genres.first.name, 'genre', 'Action'),
    );
  });
}
