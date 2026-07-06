

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: AppIcons.searchIcon,
              size: 80.r,
              color: AppColors.subtitleColor,
              strokeWidth: 2,
            ),
            SizedBox(height: 24.h),
            Text(
              'Search Movies & TV Shows',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 12.h),
            Text(
              'Start typing to discover thousands of movies, TV shows, and your next favorite watch.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.subtitleColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}