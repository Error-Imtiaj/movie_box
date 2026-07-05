import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/details/model/details_argument.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/player/presentation/services/player_service.dart';
import 'package:movie_box/feature/player/presentation/services/watch_progress_service.dart';

class TrendingSlider extends StatelessWidget {
  final List<MovieModel> movies;

  const TrendingSlider({super.key, required this.movies});

  static const imageUrl = AppStrings.tmdbTrendingImageUrl;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    final theme = Theme.of(context);

    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: 500,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: false,
      ),
      itemBuilder: (_, index, __) {
        final movie = movies[index];

        final year = movie.releaseDate.isNotEmpty
            ? movie.releaseDate.substring(0, 4)
            : "--";

        return Stack(
          fit: StackFit.expand,
          children: [
            /// Background
            AppCachedNetworkImage(
              imageUrl: "$imageUrl${movie.backdropPath}",
              fit: BoxFit.cover,
            ),

            /// Dark Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.30),
                    Colors.black.withOpacity(.60),
                    Colors.black,
                  ],
                ),
              ),
            ),

            /// Content
            Positioned(
              left: 22,
              right: 22,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Badges

                  /// Title
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// Overview
                  Text(
                    movie.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: movie.mediaType == "tv"
                              ? AppColors.mediaBadgePurpleColor
                              : AppColors.mediaBadgeRedColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.mediaType == AppStrings.smalltV
                              ? AppStrings.tvSeries
                              : AppStrings.movie,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      HugeIcon(
                        icon: AppIcons.starIcon,
                        color: AppColors.ratingBadgeIconColor,
                        size: 18,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 10),

                      HugeIcon(
                        icon: AppIcons.calenderIcon,
                        color: Colors.white70,
                        size: 15,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        year,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Buttons
                  Row(
                    children: [
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          int season = 1;
                          int episode = 1;

                          if (!movie.mediaType!.contains("movie")) {
                            final watchProgress = getIt<WatchProgressService>();

                            final progress = watchProgress
                                .getLastWatchedEpisode(tvId: movie!.id);

                            if (progress != null) {
                              season = progress['season'] as int;
                              episode = progress['episode'] as int;
                            }
                          }
                          getIt<PlayerService>().openPlayer(
                            context,
                            tmdbId: movie.id,
                            isTv: !movie.mediaType!.contains("movie"),
                            season: season,
                            episode: episode,
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text("Watch Now"),
                      ),

                      const SizedBox(width: 12),

                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white70),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          context.push(
                            Routes.detailsScreen,
                            extra: DetailsArguments(
                              id: movie.id,
                              mediaType: movie.mediaType ?? "movie",
                              heroTag: "${movie.title}_${movie.id}",
                            ),
                          );
                        },
                        icon: const Icon(Icons.info_outline),
                        label: const Text("Details"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
