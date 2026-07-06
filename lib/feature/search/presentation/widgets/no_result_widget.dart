

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';

class NoResultWidget extends StatelessWidget {
  final String? query;

  const NoResultWidget({
    super.key,
    this.query,
  });

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
              size: 72.r,
              color: AppColors.subtitleColor,
              strokeWidth: 2,
            ),
            SizedBox(height: 20.h),
            Text(
              'No Results Found',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              query == null || query!.isEmpty
                  ? 'Try searching for a movie or TV show.'
                  : 'No results found for "$query". Try a different keyword.',
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