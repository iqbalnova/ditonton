import 'package:get_it/get_it.dart';
import 'package:series/data/datasources/series_local_data_source.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/data/repositories/series_repository_impl.dart';
import 'package:series/domain/repositories/series_repository.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_series_watchlist.dart';
import 'package:series/domain/usecases/save_series_watchlist.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/provider/popular_series_notifier.dart';
import 'package:series/presentation/provider/series_detail_notifier.dart';
import 'package:series/presentation/provider/series_list_notifier.dart';
import 'package:series/presentation/provider/series_search_notifier.dart';
import 'package:series/presentation/provider/top_rated_series_notifier.dart';
import 'package:series/presentation/provider/watchlist_series_notifier.dart';

class SeriesInjection {
  static Future<void> initializeDependencies(GetIt locator) async {
    // provider
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
      () => SeriesSearchNotifier(searchSeries: locator()),
    );
    locator.registerFactory(() => PopularSeriesNotifier(locator()));
    locator.registerFactory(
      () => TopRatedSeriesNotifier(getTopRatedSeries: locator()),
    );
    locator.registerFactory(
      () => WatchlistSeriesNotifier(getWatchlistSeries: locator()),
    );

    // use case
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
    locator.registerLazySingleton<SeriesRepository>(
      () => SeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    );

    // data sources
    locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()),
    );
    locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()),
    );
  }
}
