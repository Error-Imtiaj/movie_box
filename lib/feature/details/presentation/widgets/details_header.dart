import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/details/presentation/widgets/play_button.dart';

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
  final String? tagline;
  final String? originalLanguage;

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
    this.tagline,
    this.originalLanguage,
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
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (tagline != null && tagline!.trim().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          tagline!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            // fontStyle: FontStyle.italic,
                            // color: Colors.grey,
                          ),
                        ),
                      ],

                      if (originalLanguage != null &&
                          originalLanguage!.trim().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedLanguageCircle,
                              size: 14,
                              //color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Language: ${originalLanguage!.toUpperCase()}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                // color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const HugeIcon(
                            icon: AppIcons.starIcon,
                            color: AppColors.ratingBadgeIconColor,
                            size: 18,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            rating.toStringAsFixed(1),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColorDark,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const HugeIcon(
                            icon: AppIcons.calenderIcon,
                            color: Colors.grey,
                            size: 15,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            releaseDate.isNotEmpty
                                ? releaseDate.substring(0, 4)
                                : "-",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColorDark,
                            ),
                          ),

                          if (runtime != null) ...[
                            const SizedBox(width: 14),
                            const HugeIcon(
                              icon: AppIcons.clockIcon,
                              color: Colors.grey,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              runtime!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColorDark,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12),
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
