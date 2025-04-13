import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/series.dart';
import '../repositories/series_repository.dart';

class SearchSeries {
  final SeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
