import 'features/series/data/datasources/series_local_data_source.dart';
import 'features/series/data/datasources/series_remote_data_source.dart';
import 'features/series/data/repositories/series_repository_impl.dart';
import 'features/series/domain/repositories/series_repository.dart';

import 'features/series/domain/usecases/get_now_playing_series.dart';
import 'features/series/domain/usecases/get_popular_series.dart';
import 'features/series/domain/usecases/get_series_detail.dart';
import 'features/series/domain/usecases/get_series_recommendations.dart';
import 'features/series/domain/usecases/get_top_rated_series.dart';
import 'features/series/domain/usecases/get_watchlist_series.dart';
import 'features/series/domain/usecases/get_watchlist_series_status.dart';
import 'features/series/domain/usecases/remove_series_watchlist.dart';
import 'features/series/domain/usecases/save_series_watchlist.dart';
import 'features/series/domain/usecases/search_series.dart';

import 'features/series/presentation/provider/popular_series_notifier.dart';
import 'features/series/presentation/provider/series_detail_notifier.dart';
import 'features/series/presentation/provider/series_list_notifier.dart';
import 'features/series/presentation/provider/series_search_notifier.dart';
import 'features/series/presentation/provider/top_rated_series_notifier.dart';
import 'features/series/presentation/provider/watchlist_series_notifier.dart';

import 'common/db/database_helper.dart';
import 'features/movie/data/datasources/movie_local_data_source.dart';
import 'features/movie/data/datasources/movie_remote_data_source.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/get_movie_detail.dart';
import 'features/movie/domain/usecases/get_movie_recommendations.dart';
import 'features/movie/domain/usecases/get_now_playing_movies.dart';
import 'features/movie/domain/usecases/get_popular_movies.dart';
import 'features/movie/domain/usecases/get_top_rated_movies.dart';
import 'features/movie/domain/usecases/get_watchlist_movies.dart';
import 'features/movie/domain/usecases/get_watchlist_status.dart';
import 'features/movie/domain/usecases/remove_watchlist.dart';
import 'features/movie/domain/usecases/save_watchlist.dart';
import 'features/movie/domain/usecases/search_movies.dart';
import 'features/movie/presentation/provider/movie_detail_notifier.dart';
import 'features/movie/presentation/provider/movie_list_notifier.dart';
import 'features/movie/presentation/provider/movie_search_notifier.dart';
import 'features/movie/presentation/provider/popular_movies_notifier.dart';
import 'features/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // helper
  final db = await DatabaseHelper.initDb();
  locator.registerLazySingleton<DatabaseHelper>(
      () => DatabaseHelper(database: db));

  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SeriesListNotifier(
      getNowPlayingSeries: locator(),
      getPopularSeries: locator(),
      getTopRatedSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesDetailNotifier(
      getSeriesDetail: locator(),
      getSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SeriesSearchNotifier(
      searchSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedSeriesNotifier(
      getTopRatedSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistSeriesNotifier(
      getWatchlistSeries: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
