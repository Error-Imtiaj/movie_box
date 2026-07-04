import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/const/app_strings.dart';

class MediaTypeBadge extends StatelessWidget {
  final String? mediaType;
  const MediaTypeBadge({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.mediaBadgeHorizontalPadding.w,
        vertical: AppSize.mediaBadgeVerticalPadding.h,
      ),
      decoration: BoxDecoration(
        color: mediaType == AppStrings.smalltV
            ? AppColors.mediaBadgePurpleColor
            : AppColors.mediaBadgeRedColor,
        borderRadius: BorderRadius.circular(AppSize.mediaBadgeBorderRadius.r),
      ),
      child: Text(
        (mediaType ?? '').toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.mediaBadgeTextColor,
          fontWeight: FontWeight.bold,
          fontSize: AppSize.mediaFontSize.sp,
        ),
      ),
    );
  }
}
