import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/pages/about_page.dart';
import 'package:series/presentation/bloc/home_series/home_series_bloc.dart';

import 'search_series_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';
import 'popular_series_page.dart';
import 'series_detail_page.dart';
import 'top_rated_series_page.dart';
import 'watchlist_series_page.dart';

class HomeSeriesPage extends StatefulWidget {
  final GetIt locator;
  const HomeSeriesPage({super.key, required this.locator});

  @override
  HomeSeriesPageState createState() => HomeSeriesPageState();
}

class HomeSeriesPageState extends State<HomeSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(color: Colors.grey.shade900),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Now Playing', style: kHeading6),
              BlocProvider(
                create:
                    (context) =>
                        widget.locator<HomeSeriesBloc>()
                          ..add(FetchNowPlayingSeriesEvent()),
                child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
                  builder: (context, state) {
                    if (state is HomeSeriesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is NowPlayingSeriesLoaded) {
                      return SeriesList(state.nowPlayingSeries);
                    } else if (state is HomeSeriesFailed) {
                      return Text('Failed');
                    } else {
                      return Text('Oops, Something went wrong');
                    }
                  },
                ),
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap:
                    () => {
                      Navigator.pushNamed(
                        context,
                        PopularSeriesPage.ROUTE_NAME,
                      ),
                    },
              ),
              BlocProvider(
                create:
                    (context) =>
                        widget.locator<HomeSeriesBloc>()
                          ..add(FetchPopularSeriesEvent()),
                child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
                  builder: (context, state) {
                    if (state is HomeSeriesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PopularSeriesLoaded) {
                      return SeriesList(state.popularSeries);
                    } else if (state is HomeSeriesFailed) {
                      return Text('Failed');
                    } else {
                      return Text('Oops, Something went wrong');
                    }
                  },
                ),
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap:
                    () => {
                      Navigator.pushNamed(
                        context,
                        TopRatedSeriesPage.ROUTE_NAME,
                      ),
                    },
              ),
              BlocProvider(
                create:
                    (context) =>
                        widget.locator<HomeSeriesBloc>()
                          ..add(FetchTopRatedSeriesEvent()),
                child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
                  builder: (context, state) {
                    if (state is HomeSeriesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TopRatedSeriesLoaded) {
                      return SeriesList(state.topRatedSeries);
                    } else if (state is HomeSeriesFailed) {
                      return Text('Failed');
                    } else {
                      return Text('Oops, Something went wrong');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> series;

  const SeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final seriess = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: seriess.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:
                      seriess.posterPath == null
                          ? 'https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE='
                          : '$BASE_IMAGE_URL${seriess.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
