import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/common/constants.dart';
import 'package:get_it/get_it.dart';

import '../bloc/search_series/search_series_bloc.dart';
import '../widgets/series_card_list.dart';

class SearchSeriesPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-series';

  const SearchSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<SearchSeriesBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  return TextField(
                    onSubmitted: (query) {
                      context.read<SearchSeriesBloc>().add(SearchEvent(query));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.search,
                  );
                },
              ),
              const SizedBox(height: 16),
              Text('Search Result', style: kHeading6),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<SearchSeriesBloc, SearchSeriesState>(
                  builder: (context, state) {
                    if (state is SearchSeriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchSeriesLoaded) {
                      final result = state.series;
                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return SeriesCard(result[index]);
                        },
                      );
                    } else if (state is SearchSeriesFailed) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else {
                      return const Center(child: Text(''));
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
}
