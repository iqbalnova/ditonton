import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/series_detail.dart';
import '../repositories/series_repository.dart';

class RemoveSeriesWatchlist {
  final SeriesRepository repository;

  RemoveSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.removeWatchlist(series);
  }
}
