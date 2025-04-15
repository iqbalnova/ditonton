import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';

import '../widgets/series_card_list.dart';

class PopularSeriesPage extends StatefulWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-series';

  const PopularSeriesPage({super.key, required this.locator});

  @override
  PopularSeriesPageState createState() => PopularSeriesPageState();
}

class PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              widget.locator<PopularSeriesBloc>()
                ..add(FetchPopularSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Series')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
            builder: (context, state) {
              if (state is PopularSeriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PopularSeriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final series = state.series[index];
                    return SeriesCard(series);
                  },
                  itemCount: state.series.length,
                );
              } else if (state is PopularSeriesFailed) {
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
