import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/season.dart';
import '../../domain/entities/series_detail.dart';

class SeriesSeasons extends StatelessWidget {
  const SeriesSeasons({super.key, required this.serie});

  final SeriesDetail serie;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serie.seasons.length,
      itemBuilder: (BuildContext context, int index) {
        return SeasonCard(season: serie.seasons[index]);
      },
    );
  }
}

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image
          SizedBox(
            width: 100,
            height: 150,
            child: CachedNetworkImage(
              imageUrl:
                  season.posterPath != ''
                      ? "https://image.tmdb.org/t/p/w500${season.posterPath}"
                      : 'https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE=',
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title
                  Text(
                    season.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  // Season Number
                  Text(
                    'Season ${season.seasonNumber}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 4.0),
                  // Air Date
                  Text('Air Date: ${season.airDate}'),
                  const SizedBox(height: 4.0),
                  // Episode Count
                  Text('Episode Count: ${season.episodeCount}'),
                  const SizedBox(height: 4.0),
                  // Rating Bar
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: season.voteAverage / 2,
                        itemCount: 5,
                        itemBuilder:
                            (context, index) =>
                                const Icon(Icons.star, color: kMikadoYellow),
                        itemSize: 24,
                      ),
                      const SizedBox(width: 8.0),
                      // Vote Average
                      Text('${season.voteAverage}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
