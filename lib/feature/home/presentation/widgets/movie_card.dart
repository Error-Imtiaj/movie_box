import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_meta_row.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_poster.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final String? heroTag;
  final VoidCallback? onTap;
  const MovieCard({super.key, required this.movie, this.heroTag, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.movieCardBoxRadius.r),
      splashFactory: NoSplash.splashFactory,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      focusColor: AppColors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: SizedBox(
        width: AppSize.movieCardBoxWidth.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MoviePoster(movie: movie, heroTag: heroTag),
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            MovieMetaRow(movie: movie),
          ],
        ),
      ),
    );
  }
}
