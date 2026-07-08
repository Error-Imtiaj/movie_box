

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<String> searches;
  final ValueChanged<String>? onTap;
  final ValueChanged<String>? onRemove;

  const RecentSearchWidget({
    super.key,
    required this.searches,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Searches',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: searches.map((search) {
            return InkWell(
              borderRadius: BorderRadius.circular(24.r),
              onTap: () => onTap?.call(search),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HugeIcon(
                      icon: AppIcons.searchIcon,
                      size: 16.r,
                      color: AppColors.subtitleColor,
                      strokeWidth: 2,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      search,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => onRemove?.call(search),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCancel01,
                        size: 16.r,
                        color: AppColors.subtitleColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}