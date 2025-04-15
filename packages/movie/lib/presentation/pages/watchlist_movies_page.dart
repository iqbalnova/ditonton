import 'package:core/common/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/watchlist_movie/watchlist_movie_bloc.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WatchlistMovieBloc>(),
      child: WatchlistContent(),
    );
  }
}

class WatchlistContent extends StatefulWidget {
  const WatchlistContent({super.key});

  @override
  State<WatchlistContent> createState() => _WatchlistContentState();
}

class _WatchlistContentState extends State<WatchlistContent> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistMovieLoaded) {
              if (state.movie.isEmpty) {
                return Center(child: Text("Watchlist kosong"));
              }
              return ListView.builder(
                itemCount: state.movie.length,
                itemBuilder: (context, index) {
                  final movie = state.movie[index];
                  return MovieCard(movie);
                },
              );
            } else if (state is WatchlistMovieFailed) {
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
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
