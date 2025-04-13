import 'package:core/common/state_enum.dart';

import '../provider/top_rated_series_notifier.dart';
import '../widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-series';

  const TopRatedSeriesPage({super.key});

  @override
  TopRatedSeriesPageState createState() => TopRatedSeriesPageState();
}

class TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<TopRatedSeriesNotifier>(
            // ignore: use_build_context_synchronously
            context,
            listen: false,
          ).fetchTopRatedSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.series[index];
                  return SeriesCard(series);
                },
                itemCount: data.series.length,
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
}
