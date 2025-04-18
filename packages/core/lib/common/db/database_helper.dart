import 'dart:async';

import 'package:movie/data/models/movie_table.dart';
import 'package:series/data/models/series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final Database database;

  static const String _tblSeriesWatchList = 'series_watchlist';
  static const String _tblWatchlist = 'watchlist';

  DatabaseHelper({required this.database});

  // UnTestAble
  // coverage:ignore-start
  static Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    void onCreate(Database db, int version) async {
      await db.execute('''
      CREATE TABLE $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
      ''');

      await db.execute('''
      CREATE TABLE $_tblSeriesWatchList (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
      ''');
    }

    void onUpgrade(Database db, int oldVersion, int newVersion) async {
      if (oldVersion < 2) {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tblSeriesWatchList (
          id INTEGER PRIMARY KEY,
          name TEXT,
          overview TEXT,
          posterPath TEXT
        );
        ''');
      }
    }

    final db = await openDatabase(
      databasePath,
      version: 2, // ⬅️ NAIKKAN VERSI di sini tiap ada perubahan struktur
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );

    return db;
  }

  // coverage:ignore-end

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = database;
    return await db.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = database;
    return await db.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = database;
    final results = await db.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = database;
    final List<Map<String, dynamic>> results = await db.query(_tblWatchlist);

    return results;
  }

  // Series

  Future<int> insertSeriesWatchlist(SeriesTable series) async {
    final db = database;
    return await db.insert(_tblSeriesWatchList, series.toJson());
  }

  Future<int> removeSeriesWatchlist(SeriesTable series) async {
    final db = database;
    return await db.delete(
      _tblSeriesWatchList,
      where: 'id = ?',
      whereArgs: [series.id],
    );
  }

  Future<Map<String, dynamic>?> getSeriesById(int id) async {
    final db = database;
    final results = await db.query(
      _tblSeriesWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSeries() async {
    final db = database;
    final List<Map<String, dynamic>> results = await db.query(
      _tblSeriesWatchList,
    );

    return results;
  }
}
