import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series.dart';
import '../repositories/series_repository.dart';

class GetNowPlayingSeries {
  final SeriesRepository repository;

  GetNowPlayingSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getNowPlayingSeries();
  }
}
