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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        height: 110,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(.12)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 140,
                height: 90,
                child: Stack(
                  children: [
                    AppCachedNetworkImage(
                      imageUrl: "$imageUrl${episode.stillPath ?? ""}",
                      width: 140,
                      height: 90,
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
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    episode.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Episode ${episode.episodeNumber} • ${episode.runtime} min",
                    style: theme.textTheme.bodySmall,
                  ),
                 // const SizedBox(height: 6),
                  Text(
                    episode.overview.isEmpty
                        ? "No overview available."
                        : episode.overview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500,
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