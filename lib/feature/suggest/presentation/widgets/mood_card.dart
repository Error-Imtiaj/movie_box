import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class MoodCard extends StatelessWidget {
  final String title;
  final List<List<dynamic>> icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        splashFactory: NoSplash.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.buttonBackgroundColor
                : AppColors.cardColor,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.buttonBackgroundColor
                  : AppColors.borderColor.withOpacity(.35),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.buttonBackgroundColor.withOpacity(.25),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : const [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: icon,
                size: 26.r,
                strokeWidth: 2,
                color: isSelected
                    ? Colors.white
                    : AppColors.buttonBackgroundColor,
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
