import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/watchlist_series_notifier.dart';
import '../widgets/series_card_list.dart';

class WatchlistSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-series';

  const WatchlistSeriesPage({super.key});

  @override
  WatchlistSeriesPageState createState() => WatchlistSeriesPageState();
}

class WatchlistSeriesPageState extends State<WatchlistSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<WatchlistSeriesNotifier>(
            // ignore: use_build_context_synchronously
            context,
            listen: false,
          ).fetchWatchlistSeries(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistSeriesNotifier>(
      context,
      listen: false,
    ).fetchWatchlistSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistSeriesNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.watchlistSeries[index];
                  return SeriesCard(series);
                },
                itemCount: data.watchlistSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
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
