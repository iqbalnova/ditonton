import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/series_local_data_source.dart';
import '../datasources/series_remote_data_source.dart';
import '../models/series_table.dart';
import '../../domain/entities/series.dart';
import '../../domain/entities/series_detail.dart';
import '../../domain/repositories/series_repository.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDataSource remoteDataSource;
  final SeriesLocalDataSource localDataSource;

  SeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Series>>> getNowPlayingSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getPopularSeries() async {
    try {
      final result = await remoteDataSource.getPopularSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getTopRatedSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getWatchlistSeries() async {
    final result = await localDataSource.getWatchlistSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail series) async {
    try {
      final result = await localDataSource.removeWatchlist(
        SeriesTable.fromEntity(series),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail series) async {
    try {
      final result = await localDataSource.insertWatchlist(
        SeriesTable.fromEntity(series),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Series>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
