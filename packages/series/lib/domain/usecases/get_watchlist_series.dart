import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
