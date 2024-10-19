import 'features/movies/presentation/provider/movie_detail_notifier.dart';
import 'features/movies/presentation/provider/movie_list_notifier.dart';
import 'features/movies/presentation/provider/movie_search_notifier.dart';
import 'features/movies/presentation/provider/popular_movies_notifier.dart';
import 'features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movies/presentation/provider/watchlist_movie_notifier.dart';

import 'features/core/router/router.dart';
import 'features/movies/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'common/constants.dart';
import 'common/utils.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
