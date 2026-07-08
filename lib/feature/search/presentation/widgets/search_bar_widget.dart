

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onChanged: onChanged,
        onSubmitted: (_) => onSubmitted?.call(),
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: 'Search movies, TV shows...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.r),
            child: HugeIcon(
              icon: AppIcons.searchIcon,
              size: AppSize.defaultIconSize.r,
              color: AppColors.subtitleColor,
              strokeWidth: 2,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 52.w,
            minHeight: 52.h,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedCancel01,
                    size: AppSize.defaultIconSize.r,
                    color: AppColors.subtitleColor,
                    strokeWidth: 2,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}