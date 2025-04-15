import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/popular_movie/popular_movie_bloc.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key, required this.locator});

  @override
  PopularMoviesPageState createState() => PopularMoviesPageState();
}

class PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              widget.locator<PopularMovieBloc>()..add(FetchPopularMovieEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Movie')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
              if (state is PopularMovieLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PopularMovieLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movie[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movie.length,
                );
              } else if (state is PopularMovieFailed) {
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
