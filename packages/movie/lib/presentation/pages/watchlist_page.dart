import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class WatchlistPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<WatchlistMovieBloc>()),
        BlocProvider(create: (context) => locator<WatchlistSeriesBloc>()),
      ],
      child: const WatchlistContent(),
    );
  }
}

class WatchlistContent extends StatefulWidget {
  const WatchlistContent({super.key});

  @override
  State<WatchlistContent> createState() => _WatchlistContentState();
}

class _WatchlistContentState extends State<WatchlistContent>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchWatchlists();
  }

  void _fetchWatchlists() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvent());
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeriesEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _fetchWatchlists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Movies'), Tab(text: 'TV Series')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildMoviesWatchlist(), _buildSeriesWatchlist()],
      ),
    );
  }

  Widget _buildMoviesWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WatchlistMovieLoaded) {
            if (state.movie.isEmpty) {
              return const Center(child: Text("Movies watchlist is empty"));
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
              key: const Key('movie_error_message'),
              child: Text(state.error),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _buildSeriesWatchlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
        builder: (context, state) {
          if (state is WatchlistSeriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WatchlistSeriesLoaded) {
            if (state.series.isEmpty) {
              return const Center(child: Text("TV Series watchlist is empty"));
            }
            return ListView.builder(
              itemCount: state.series.length,
              itemBuilder: (context, index) {
                final series = state.series[index];
                return SeriesCard(series);
              },
            );
          } else if (state is WatchlistSeriesFailed) {
            return Center(
              key: const Key('series_error_message'),
              child: Text(state.error),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
