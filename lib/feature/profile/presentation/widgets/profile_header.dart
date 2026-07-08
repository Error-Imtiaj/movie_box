import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppColors.navigationBarBackgroundColor.withOpacity(.18),
            AppColors.navigationBarBackgroundColor.withOpacity(.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.navigationBarBackgroundColor.withOpacity(.15),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: AppColors.navigationBarBackgroundColor.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedUserCircle,
              size: 52,
              color: AppColors.navigationBarBackgroundColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "CineVerse",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your Ultimate Movie & TV Companion",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.navigationBarBackgroundColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HugeIcon(
                 icon: HugeIcons.strokeRoundedKey01,
                  size: 18,
                  color: AppColors.navigationBarBackgroundColor,
                ),
                SizedBox(width: 8),
                Text(
                  "Powered by TMDB API",
                  style: TextStyle(
                    color: AppColors.navigationBarBackgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}