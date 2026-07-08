import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/common/app_cache_network_image.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/media_type_badge.dart';
import 'package:movie_box/feature/home/presentation/widgets/rating_badge.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/feature/favourite/bloc/favourite_bloc.dart';

class MoviePoster extends StatelessWidget {
  final MovieModel movie;
  final String? heroTag;
  const MoviePoster({super.key, required this.movie, this.heroTag});

  @override
  Widget build(BuildContext context) {
    const String imageUrl = AppStrings.tmdbMovieImageUrl;
    Widget poster = Stack(
      children: [
        AppCachedNetworkImage(
          imageUrl: "$imageUrl${movie.posterPath}",
          width: AppSize.moviePosterWidth.w,
          height: AppSize.moviePosterHeight.h,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(
            AppSize.moviePosterBorderRadius.r,
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSize.moviePosterBorderRadius.r,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.black26,
                  AppColors.black87,
                ],
              ),
            ),
          ),
        ),
        // Media type badge
        Positioned(
          top: 10,
          left: 10,
          child: MediaTypeBadge(mediaType: movie.mediaType),
        ),
        // Rating badge
        Positioned(
          top: 10,
          right: 10,
          child: RatingBadge(rating: movie.voteAverage),
        ),
        // Favourite button
        Positioned(
          bottom: 10,
          right: 10,
          child: BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              final isFavourite =
                  state is FavouriteLoaded &&
                  state.movies.any((m) => m.id == movie.id);

              return Material(
                color: Colors.black.withOpacity(.45),
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
                      color: isFavourite ? Colors.red : Colors.white,
                      size: 20.sp,
                     // secondaryColor: Colors.blueAccent,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
    if (heroTag != null) {
      return Hero(tag: heroTag!, child: poster);
    }
    return poster;
  }
}
