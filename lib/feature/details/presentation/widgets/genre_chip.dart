import 'package:flutter/material.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/feature/details/model/genre_model.dart';

class GenreChip extends StatelessWidget {
  final GenreModel genre;

  const GenreChip({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.homeScreenSeeAllBackgroundColor.withOpacity(.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.homeScreenSeeAllBackgroundColor.withOpacity(.3),
        ),
      ),
      child: Text(
        genre.name,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.homeScreenSeeAllBackgroundColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}