import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/about_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_page.dart';
import 'package:series/presentation/pages/home_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
        drawerTheme: kDrawerTheme,
      ),
      home: HomeMoviePage(locator: di.locator),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(
                builder: (_) => HomeMoviePage(locator: di.locator));
          case '/home-series':
            return MaterialPageRoute(
                builder: (_) => HomeSeriesPage(locator: di.locator));
          case PopularMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => PopularMoviesPage(locator: di.locator));
          case PopularSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => PopularSeriesPage(locator: di.locator));
          case TopRatedMoviesPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => TopRatedMoviesPage(locator: di.locator));
          case TopRatedSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => TopRatedSeriesPage(locator: di.locator));
          case MovieDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailPage(id: id, locator: di.locator),
              settings: settings,
            );
          case SeriesDetailPage.ROUTE_NAME:
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => SeriesDetailPage(id: id, locator: di.locator),
              settings: settings,
            );
          case SearchPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => SearchPage(locator: di.locator));
          case SearchSeriesPage.ROUTE_NAME:
            return CupertinoPageRoute(
                builder: (_) => SearchSeriesPage(locator: di.locator));
          case WatchlistPage.ROUTE_NAME:
            return MaterialPageRoute(
                builder: (_) => WatchlistPage(locator: di.locator));

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
      },
    );
  }
}
