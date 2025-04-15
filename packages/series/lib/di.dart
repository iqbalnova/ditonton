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
import 'package:series/presentation/bloc/home_series/home_series_bloc.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';

class SeriesInjection {
  static Future<void> initializeDependencies(GetIt locator) async {
    // BLoC
    locator.registerFactory(() => SearchSeriesBloc(searchSeries: locator()));
    locator.registerFactory(
      () => TopRatedSeriesBloc(getTopRatedSeries: locator()),
    );
    locator.registerFactory(
      () => PopularSeriesBloc(getPopularSeries: locator()),
    );
    locator.registerFactory(
      () => SeriesDetailBloc(
        getSeriesDetail: locator(),
        getSeriesRecommendations: locator(),
        getWatchListSeriesStatus: locator(),
        saveSeriesWatchlist: locator(),
        removeSeriesWatchlist: locator(),
      ),
    );
    locator.registerFactory(
      () => WatchlistSeriesBloc(getWatchlistSeries: locator()),
    );
    locator.registerFactory(
      () => HomeSeriesBloc(
        getNowPlayingSeries: locator(),
        getPopularSeries: locator(),
        getTopRatedSeries: locator(),
      ),
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
