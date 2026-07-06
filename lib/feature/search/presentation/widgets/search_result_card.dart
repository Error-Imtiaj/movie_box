import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class SearchResultCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback? onTap;

  const SearchResultCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.white.withOpacity(.05),
          ),
        ),
        child: Row(
          children: [
            Hero(
              tag: "search_${movie.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  movie.posterPath,
                  width: 80.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedVideo01,
                        size: 30.r,
                        color: AppColors.subtitleColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: SizedBox(
                height: 120.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    SizedBox(height: 10.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(.15),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HugeIcon(
                            icon: AppIcons.starIcon,
                            size: 14.r,
                            color: Colors.amber,
                            strokeWidth: 2,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        HugeIcon(
                          icon: AppIcons.calenderIcon,
                          size: 16.r,
                          color: AppColors.subtitleColor,
                          strokeWidth: 2,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            movie.releaseDate,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      movie.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 8.w),

            HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              size: 22.r,
              color: AppColors.subtitleColor,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}