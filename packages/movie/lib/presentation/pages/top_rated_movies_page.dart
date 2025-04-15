import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/top_rated_movie/top_rated_movie_bloc.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key, required this.locator});

  @override
  TopRatedMoviesPageState createState() => TopRatedMoviesPageState();
}

class TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              widget.locator<TopRatedMovieBloc>()
                ..add(FetchTopRatedMovieEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Top Rated Movie')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state) {
              if (state is TopRatedMovieLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TopRatedMovieLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movie[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movie.length,
                );
              } else if (state is TopRatedMovieFailed) {
                return Center(
                  key: Key('error_message'),
                  child: Text(state.error),
                );
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}
