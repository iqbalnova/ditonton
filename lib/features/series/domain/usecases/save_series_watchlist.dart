import 'package:dartz/dartz.dart';
import '../../../../common/failure.dart';
import '../entities/series_detail.dart';
import '../repositories/series_repository.dart';

class SaveSeriesWatchlist {
  final SeriesRepository repository;

  SaveSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.saveWatchlist(series);
  }
}
