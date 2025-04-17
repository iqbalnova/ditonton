import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/pages/watchlist_page.dart';
import '../../domain/entities/movie.dart';
import '../bloc/home_movie/home_movie_bloc.dart';
import 'about_page.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'search_page.dart';
import 'top_rated_movies_page.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  final GetIt locator;
  const HomeMoviePage({super.key, required this.locator});

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home-series');
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
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
        title: Text('Ditonton Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
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
                        widget.locator<HomeMovieBloc>()
                          ..add(FetchNowPlayingMovieEvent()),
                child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                    if (state is HomeMovieLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is NowPlayingMovieLoaded) {
                      return MovieList(state.nowPlayingMovie);
                    } else if (state is HomeMovieFailed) {
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
                        PopularMoviesPage.ROUTE_NAME,
                      ),
                    },
              ),
              BlocProvider(
                create:
                    (context) =>
                        widget.locator<HomeMovieBloc>()
                          ..add(FetchPopularMovieEvent()),
                child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                    if (state is HomeMovieLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is PopularMovieLoaded) {
                      return MovieList(state.popularMovie);
                    } else if (state is HomeMovieFailed) {
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
                        TopRatedMoviesPage.ROUTE_NAME,
                      ),
                    },
              ),
              BlocProvider(
                create:
                    (context) =>
                        widget.locator<HomeMovieBloc>()
                          ..add(FetchTopRatedMovieEvent()),
                child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
                  builder: (context, state) {
                    if (state is HomeMovieLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TopRatedMovieLoaded) {
                      return MovieList(state.topRatedMovie);
                    } else if (state is HomeMovieFailed) {
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

class MovieList extends StatelessWidget {
  final List<Movie> movie;

  const MovieList(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movies = movie[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movies.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl:
                      movies.posterPath == null
                          ? 'https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE='
                          : '$BASE_IMAGE_URL${movies.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movie.length,
      ),
    );
  }
}
