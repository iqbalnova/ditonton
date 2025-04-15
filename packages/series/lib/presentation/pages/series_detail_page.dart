import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:series/presentation/bloc/series_detail/series_detail_bloc.dart';

import '../../domain/entities/series.dart';
import '../../domain/entities/series_detail.dart';
import '../widgets/series_seasons.dart';

class SeriesDetailPage extends StatelessWidget {
  final GetIt locator;
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail-series';

  final int id;
  const SeriesDetailPage({super.key, required this.id, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              locator<SeriesDetailBloc>()
                ..add(FetchSeriesDetailEvent(seriesId: id)),
      child: Scaffold(
        body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
          builder: (context, state) {
            if (state is SeriesDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SeriesDetailLoaded) {
              final series = state.seriesDetail;
              return BlocProvider(
                create: (context) => locator<SeriesDetailBloc>(),
                child: SafeArea(
                  child: DetailContent(series, state.seriesRecommendations),
                ),
              );
            } else if (state is SeriesDetailFailed) {
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
  final SeriesDetail series;
  final List<Series> recommendations;

  const DetailContent(this.series, this.recommendations, {super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isAddedWatchlist = false;
  @override
  void initState() {
    super.initState();
    context.read<SeriesDetailBloc>().add(
      GetWatchlistSeriesStatusEvent(seriesId: widget.series.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              widget.series.posterPath != null
                  ? "https://image.tmdb.org/t/p/w500${widget.series.posterPath}"
                  : 'https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE=',
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
                            Text(widget.series.name, style: kHeading5),
                            const SizedBox(height: 8),
                            BlocListener<SeriesDetailBloc, SeriesDetailState>(
                              listener: (context, state) {
                                if (state is WatchlistChangeSuccess) {
                                  if (state.message ==
                                          SeriesDetailBloc
                                              .watchlistAddSuccessMessage ||
                                      state.message ==
                                          SeriesDetailBloc
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
                                    context.read<SeriesDetailBloc>().add(
                                      SaveWatchlistSeriesEvent(
                                        serie: widget.series,
                                      ),
                                    );
                                  } else {
                                    context.read<SeriesDetailBloc>().add(
                                      RemoveWatchlistSeriesEvent(
                                        serie: widget.series,
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
                            Text(_showGenres(widget.series.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.series.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 24,
                                ),
                                const SizedBox(width: 8),
                                Text('${widget.series.voteAverage}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(widget.series.overview),
                            const SizedBox(height: 16),
                            Text('Seasons', style: kHeading6),
                            SeriesSeasons(serie: widget.series),
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
                                      final series =
                                          widget.recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              SeriesDetailPage.ROUTE_NAME,
                                              arguments: series.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  series.posterPath != null
                                                      ? "https://image.tmdb.org/t/p/w500${series.posterPath}"
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
