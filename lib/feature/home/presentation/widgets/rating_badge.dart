
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.black87,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          HugeIcon(
            icon: AppIcons.starIcon,
            color: AppColors.ratingBadgeIconColor,
            size: 14,
          ),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style:  Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.ratingBadgeTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
