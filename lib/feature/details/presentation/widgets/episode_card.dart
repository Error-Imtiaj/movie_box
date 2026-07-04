import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/details/model/episode_model.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeModel episode;
  final VoidCallback? onTap;

  const EpisodeCard({
    super.key,
    required this.episode,
    this.onTap,
  });

  static const imageUrl = AppStrings.tmdbTrendingImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Stack(
                children: [
                  AppCachedNetworkImage(
                    imageUrl: "$imageUrl${episode.stillPath ?? ""}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),

                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black26,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 14,
                    bottom: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Episode ${episode.episodeNumber}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          HugeIcon(
                            icon: AppIcons.starIcon,
                            color: AppColors.ratingBadgeIconColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            episode.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned.fill(
                    child: Center(
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        "${episode.runtime} min",
                        style: theme.textTheme.bodySmall,
                      ),

                      const SizedBox(width: 16),

                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 15,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        episode.airDate,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    episode.overview.isEmpty
                        ? "No overview available."
                        : episode.overview,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade400,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}