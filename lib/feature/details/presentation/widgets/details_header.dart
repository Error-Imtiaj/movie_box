import 'package:flutter/material.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_strings.dart';

class DetailsHeader extends StatelessWidget {
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final String overview;
  final double rating;
  final String releaseDate;
  final List<String> genres;
  final bool isTv;
  final String? runtime;
  final VoidCallback? onPlayTrailer;

  const DetailsHeader({
    super.key,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.genres,
    required this.isTv,
    this.runtime,
    this.onPlayTrailer,
  });

  static const backdropUrl = AppStrings.tmdbTrendingImageUrl;
  static const posterUrl = AppStrings.tmdbMovieImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 340,
          width: double.infinity,
          child: AppCachedNetworkImage(
            imageUrl: "$backdropUrl$backdropPath",
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.15),
                  Colors.black.withOpacity(.35),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 20,
          right: 20,
          bottom: -70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Hero(
                tag: "details_$title",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AppCachedNetworkImage(
                    imageUrl: "$posterUrl$posterPath",
                    width: 120,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: genres
                            .map(
                              (genre) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.textColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  genre,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Icon(
                            Icons.calendar_today,
                            size: 15,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            releaseDate.isNotEmpty
                                ? releaseDate.substring(0, 4)
                                : "-",
                          ),

                          if (runtime != null) ...[
                            const SizedBox(width: 14),
                            const Icon(
                              Icons.schedule,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(runtime!),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12),

                      FilledButton.icon(
                        onPressed: onPlayTrailer,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Watch Trailer"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}