

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class SuggestEmptyWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const SuggestEmptyWidget({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedMagicWand01,
                  size: 52.r,
                  color: AppColors.buttonBackgroundColor,
                  strokeWidth: 2,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Suggestions Yet',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Try selecting a different mood or genre, or let MovieBox surprise you with a new recommendation.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: 220.w,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedRefresh,
                  size: 18.r,
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                label: const Text('Refresh Suggestions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}