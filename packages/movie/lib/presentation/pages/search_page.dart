import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/search_movie/search_movie_bloc.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-movie';

  const SearchPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<SearchMovieBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search Movies')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  return TextField(
                    onSubmitted: (query) {
                      context.read<SearchMovieBloc>().add(SearchEvent(query));
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
                child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
                  builder: (context, state) {
                    if (state is SearchMovieLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchMovieLoaded) {
                      final result = state.movie;
                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return MovieCard(result[index]);
                        },
                      );
                    } else if (state is SearchMovieFailed) {
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
