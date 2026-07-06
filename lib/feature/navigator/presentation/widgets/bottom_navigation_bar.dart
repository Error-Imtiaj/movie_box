import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';
import 'package:movie_box/core/const/app_size.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      surfaceTintColor: Colors.transparent,
      shape: const CircularNotchedRectangle(),
      notchMargin: AppSize.navigationBarNotchMargin,
      color: AppColors.navigationBarBackgroundColor,
      // elevation: 12,
      child: SafeArea(
        child: SizedBox(
          height: AppSize.navigationBarHeight,
          child: Row(
            children: [
              Expanded(
                child: _navItem(
                  icon: AppIcons.homeIcon,
                  label: "Home",
                  index: 0,
                ),
              ),

              Expanded(
                child: _navItem(
                  icon: AppIcons.searchIcon,
                  label: "Search",
                  index: 1,
                ),
              ),

              const SizedBox(width: 70),

              Expanded(
                child: _navItem(
                  icon: AppIcons.favouriteIcon,
                  label: "Favorite",
                  index: 3,
                ),
              ),

              Expanded(
                child: _navItem(
                  icon: AppIcons.profileIcon,
                  label: "Profile",
                  index: 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required List<List<dynamic>> icon,
    required String label,
    required int index,
  }) {
    final bool selected = currentIndex == index;

    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      focusColor: AppColors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: icon,
            size: AppSize.navigationBarIconSize.r,
            strokeWidth: AppSize.navigationIconStrokeWidth,
            color: selected
                ? AppColors.navigationBarSelectedItemColor
                : AppColors.navigationBarUnselectedItemColor,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: AppSize.navigationTextSize.sp,
              fontWeight: FontWeight.w700,
              color: selected
                  ? AppColors.navigationBarSelectedItemColor
                  : AppColors.navigationBarUnselectedItemColor,
            ),
          ),
        ],
      ),
    );
  }
}
