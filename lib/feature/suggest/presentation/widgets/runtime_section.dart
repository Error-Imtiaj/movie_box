

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class RuntimeSection extends StatelessWidget {
  final int? selectedRuntime;
  final ValueChanged<int> onSelected;

  const RuntimeSection({
    super.key,
    required this.selectedRuntime,
    required this.onSelected,
  });

  static const List<Map<String, dynamic>> _items = [
    {'label': 'Under 90 min', 'value': 90},
    {'label': '90–120 min', 'value': 120},
    {'label': '2+ Hours', 'value': 180},
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedClock01,
                size: 20.r,
                color: AppColors.buttonBackgroundColor,
                strokeWidth: 2,
              ),
              SizedBox(width: 8.w),
              Text(
                'Runtime',
                style: textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: _items.map((item) {
              final selected = selectedRuntime == item['value'];

              return ChoiceChip(
                label: Text(item['label'] as String),
                selected: selected,
                onSelected: (_) => onSelected(item['value'] as int),
                selectedColor: AppColors.buttonBackgroundColor,
                backgroundColor: AppColors.cardColor,
                labelStyle: textTheme.bodyMedium?.copyWith(
                  color: selected ? Colors.white : AppColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                side: BorderSide.none,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}