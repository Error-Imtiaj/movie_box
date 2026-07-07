

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_icons.dart';

class MoodGrid extends StatelessWidget {
  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  const MoodGrid({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  static const List<_MoodItem> _moods = [
    _MoodItem('Action', AppIcons.actionIcon),
    _MoodItem('Comedy', AppIcons.comedyIcon),
    _MoodItem('Romance', AppIcons.romanceIcon),
    _MoodItem('Horror', AppIcons.horrorIcon),
    _MoodItem('Sci-Fi', AppIcons.sciFiIcon),
    _MoodItem('Animation', AppIcons.animationIcon),
    _MoodItem('Family', AppIcons.familyIcon),
    _MoodItem('Thriller', AppIcons.thrillerIcon),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Mood',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _moods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: .9,
            ),
            itemBuilder: (context, index) {
              final mood = _moods[index];
              final selected = mood.name == selectedMood;

              return InkWell(
                onTap: () => onMoodSelected(mood.name),
                borderRadius: BorderRadius.circular(18.r),
                splashFactory: NoSplash.splashFactory,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.buttonBackgroundColor
                        : AppColors.cardColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: mood.icon,
                        size: 24.r,
                        color: selected
                            ? Colors.white
                            : AppColors.buttonBackgroundColor,
                        strokeWidth: 2,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        mood.name,
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: selected ? Colors.white : AppColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MoodItem {
  final String name;
  final List<List<dynamic>> icon;

  const _MoodItem(this.name, this.icon);
}