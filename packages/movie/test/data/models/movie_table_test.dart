import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  const testMovieTable = MovieTable(
    id: 1,
    title: 'Inception',
    posterPath: '/poster.jpg',
    overview: 'Mind-bending thriller.',
  );

  const testMovieDetail = MovieDetail(
    id: 1,
    title: 'Inception',
    overview: 'Mind-bending thriller.',
    posterPath: '/poster.jpg',
    adult: false,
    backdropPath: '/backdrop.jpg',
    genres: [],
    originalTitle: 'Inception',
    voteAverage: 8.8,
    voteCount: 10000,
    releaseDate: '2010-07-16',
    runtime: 148,
  );

  test('should return MovieTable from MovieDetail entity', () {
    final result = MovieTable.fromEntity(testMovieDetail);
    expect(result, testMovieTable);
  });

  test('should return MovieTable from map', () {
    final map = {
      'id': 1,
      'title': 'Inception',
      'posterPath': '/poster.jpg',
      'overview': 'Mind-bending thriller.',
    };
    final result = MovieTable.fromMap(map);
    expect(result, testMovieTable);
  });

  test('should convert MovieTable to JSON', () {
    final result = testMovieTable.toJson();
    final expectedJson = {
      'id': 1,
      'title': 'Inception',
      'posterPath': '/poster.jpg',
      'overview': 'Mind-bending thriller.',
    };
    expect(result, expectedJson);
  });

  test('should convert MovieTable to Movie entity', () {
    final result = testMovieTable.toEntity();
    final expected = Movie.watchlist(
      id: 1,
      title: 'Inception',
      posterPath: '/poster.jpg',
      overview: 'Mind-bending thriller.',
    );
    expect(result, expected);
  });
}
