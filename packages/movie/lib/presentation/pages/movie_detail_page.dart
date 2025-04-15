import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/movie_detail/movie_detail_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              locator<MovieDetailBloc>()
                ..add(FetchMovieDetailEvent(movieId: id)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movieDetail;
              return BlocProvider(
                create: (context) => locator<MovieDetailBloc>(),
                child: SafeArea(
                  child: DetailContent(movie, state.movieRecommendations),
                ),
              );
            } else if (state is MovieDetailFailed) {
              return Text(state.error);
            } else {
              return Text('');
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;

  const DetailContent(this.movie, this.recommendations, {super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isAddedWatchlist = false;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(
      GetWatchlistMovieStatusEvent(movieId: widget.movie.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
          width: screenWidth,
          placeholder:
              (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.movie.originalTitle, style: kHeading5),
                            const SizedBox(height: 8),
                            BlocListener<MovieDetailBloc, MovieDetailState>(
                              listener: (context, state) {
                                if (state is WatchlistChangeSuccess) {
                                  if (state.message ==
                                          MovieDetailBloc
                                              .watchlistAddSuccessMessage ||
                                      state.message ==
                                          MovieDetailBloc
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(state.message),
                                        );
                                      },
                                    );
                                  }
                                }

                                if (state is WatchlistStatusLoaded) {
                                  setState(() {
                                    isAddedWatchlist = state.isAddedWatchlist;
                                  });
                                }
                              },
                              child: FilledButton(
                                onPressed: () {
                                  if (!isAddedWatchlist) {
                                    context.read<MovieDetailBloc>().add(
                                      SaveWatchlistMovieEvent(
                                        movie: widget.movie,
                                      ),
                                    );
                                  } else {
                                    context.read<MovieDetailBloc>().add(
                                      RemoveWatchlistMovieEvent(
                                        movie: widget.movie,
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? Icon(Icons.check)
                                        : Icon(Icons.add),
                                    Text(' Watchlist'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(_showGenres(widget.movie.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 24,
                                ),
                                const SizedBox(width: 8),
                                Text('${widget.movie.voteAverage}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(widget.movie.overview),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            const SizedBox(height: 8),
                            widget.recommendations.isEmpty
                                ? Text('No recommendations available')
                                : SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.recommendations.length,
                                    itemBuilder: (context, index) {
                                      final movie =
                                          widget.recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MovieDetailPage.ROUTE_NAME,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  movie.posterPath != null
                                                      ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                                                      : 'https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE=',
                                              placeholder:
                                                  (context, url) => Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    if (genres.isEmpty) return '';
    return genres.map((genre) => genre.name).join(', ');
  }
}
