import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../movies/presentation/pages/about_page.dart';
import '../../movies/presentation/pages/home_movie_page.dart';
import '../../movies/presentation/pages/movie_detail_page.dart';
import '../../movies/presentation/pages/popular_movies_page.dart';
import '../../movies/presentation/pages/search_page.dart';
import '../../movies/presentation/pages/top_rated_movies_page.dart';
import '../../movies/presentation/pages/watchlist_movies_page.dart';
import '../../series/presentation/pages/home_series_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeMoviePage());
      case '/home-series':
        return MaterialPageRoute(builder: (_) => HomeSeriesPage());
      case PopularMoviesPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
      case TopRatedMoviesPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case MovieDetailPage.ROUTE_NAME:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case SearchPage.ROUTE_NAME:
        return CupertinoPageRoute(builder: (_) => SearchPage());
      case WatchlistMoviesPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
      case AboutPage.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  }
}
