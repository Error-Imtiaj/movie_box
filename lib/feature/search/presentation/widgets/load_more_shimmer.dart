import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:shimmer/shimmer.dart';

class LoadMoreShimmer extends StatelessWidget {
  const LoadMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: AppSize.moviePosterWidth / AppSize.moviePosterHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppSize.moviePosterBorderRadius.r,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 16.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: 80.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    );
  }
}
