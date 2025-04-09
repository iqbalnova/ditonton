import 'package:ditonton/common/db/database_helper.dart';
import 'package:ditonton/features/series/data/datasources/series_local_data_source.dart';
import 'package:ditonton/features/series/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/features/series/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
