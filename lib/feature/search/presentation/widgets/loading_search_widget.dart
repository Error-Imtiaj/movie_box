

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_size.dart';

class LoadingSearchWidget extends StatelessWidget {
  const LoadingSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.defaultPadding.w,
        vertical: 8.h,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 18.h,
        childAspectRatio: .58,
      ),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: AppColors.cardColor,
          highlightColor: AppColors.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 16.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 12.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}