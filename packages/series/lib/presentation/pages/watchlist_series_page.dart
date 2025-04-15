import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';

import '../widgets/series_card_list.dart';

class WatchlistSeriesPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-series';

  const WatchlistSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WatchlistSeriesBloc>(),
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
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeriesEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
          builder: (context, state) {
            if (state is WatchlistSeriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WatchlistSeriesLoaded) {
              if (state.series.isEmpty) {
                return Center(child: Text("Watchlist kosong"));
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
