
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class MovieMetaRow extends StatelessWidget {
  final MovieModel movie;
  const MovieMetaRow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        HugeIcon(
          icon : AppIcons.calenderIcon,
          size: AppSize.movieCalenderIconSize,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 4),
        Text(
          movie.releaseDate.isNotEmpty
              ? movie.releaseDate.substring(0, 4)
              : "----",
          style: textTheme.bodySmall?.copyWith(color: AppColors.movieCardSubtitleColor),
        ),
        const SizedBox(width: 8),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.movieCardSubtitleColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          movie.mediaType == AppStrings.smalltV ? AppStrings.tvSeries : AppStrings.movie,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.movieCardSubtitleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
