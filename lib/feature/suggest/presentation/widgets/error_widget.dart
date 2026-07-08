

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class SuggestErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const SuggestErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedAlert02,
                  size: 42.r,
                  color: AppColors.error,
                  strokeWidth: 2,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Something went wrong',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 28.h),
            SizedBox(
              width: 180.w,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedRefresh,
                  size: 18.r,
                  color: Colors.white,
                  strokeWidth: 2,
                ),
                label: const Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}