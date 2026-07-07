import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_meta_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/feature/favourite/bloc/favourite_bloc.dart';

class MovieGridItem extends StatelessWidget {
  final MovieModel movie;
  final String? heroTag;
  final VoidCallback? onTap;

  const MovieGridItem({
    super.key,
    required this.movie,
    this.onTap,
    this.heroTag,
  });

  static const imageUrl = AppStrings.tmdbMovieImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: heroTag ?? "home_${movie.id}",
              child: Stack(
                children: [
                  AppCachedNetworkImage(
                    imageUrl: "$imageUrl${movie.posterPath}",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(.85),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           HugeIcon(
                            icon : AppIcons.starIcon,
                            color: AppColors.ratingBadgeIconColor,
                            size: 14,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: BlocBuilder<FavouriteBloc, FavouriteState>(
                      builder: (context, state) {
                        final isFavourite =
                            state is FavouriteLoaded &&
                            state.movies.any((m) => m.id == movie.id);

                        return Material(
                          color: Colors.black.withValues(alpha: .45),
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              context.read<FavouriteBloc>().add(
                                    ToggleFavourite(movie),
                                  );
                            },
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedFavourite,
                                color: isFavourite
                                    ? Colors.red
                                    : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  if (movie.adult)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "18+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),
          MovieMetaRow(movie: movie),
         
        ],
      ),
    );
  }
}
