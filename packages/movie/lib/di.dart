import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import 'presentation/bloc/home_movie/home_movie_bloc.dart';
import 'presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

class MovieInjection {
  static Future<void> initializeDependencies(GetIt locator) async {
    // BLoC
    locator.registerFactory(() => SearchMovieBloc(searchMovie: locator()));
    locator.registerFactory(
      () => TopRatedMovieBloc(getTopRatedMovie: locator()),
    );
    locator.registerFactory(() => PopularMovieBloc(getPopularMovie: locator()));
    locator.registerFactory(
      () => MovieDetailBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListMovieStatus: locator(),
        saveMovieWatchlist: locator(),
        removeMovieWatchlist: locator(),
      ),
    );
    locator.registerFactory(
      () => WatchlistMovieBloc(getWatchlistMovie: locator()),
    );
    locator.registerFactory(
      () => HomeMovieBloc(
        getNowPlayingMovie: locator(),
        getPopularMovie: locator(),
        getTopRatedMovie: locator(),
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

    // repository
    locator.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    );

    // data sources
    locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()),
    );
    locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()),
    );
  }
}
