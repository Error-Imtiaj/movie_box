

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final int? selectedGenreId;
  final int? selectedRuntime;
  final ValueChanged<int?> onGenreChanged;
  final ValueChanged<int?> onRuntimeChanged;
  final VoidCallback onApply;
  final VoidCallback onReset;

  const FilterBottomSheet({
    super.key,
    required this.selectedGenreId,
    required this.selectedRuntime,
    required this.onGenreChanged,
    required this.onRuntimeChanged,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late int? genre = widget.selectedGenreId;
  late int? runtime = widget.selectedRuntime;

  static const genres = {
    28: 'Action',
    35: 'Comedy',
    18: 'Drama',
    27: 'Horror',
    10749: 'Romance',
    878: 'Sci-Fi',
    16: 'Animation',
    53: 'Thriller',
  };

  static const runtimes = {
    90: 'Under 90 min',
    120: '90–120 min',
    180: '2+ Hours',
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 48.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedFilterHorizontal,
                    size: 22.r,
                    color: AppColors.buttonBackgroundColor,
                    strokeWidth: 2,
                  ),
                  SizedBox(width: 10.w),
                  Text('Filters', style: textTheme.headlineMedium),
                ],
              ),
              SizedBox(height: 24.h),
              Text('Genre', style: textTheme.titleMedium),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: genres.entries.map((e) => ChoiceChip(
                  label: Text(e.value),
                  selected: genre == e.key,
                  onSelected: (_) => setState(() => genre = e.key),
                )).toList(),
              ),
              SizedBox(height: 24.h),
              Text('Runtime', style: textTheme.titleMedium),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: runtimes.entries.map((e) => ChoiceChip(
                  label: Text(e.value),
                  selected: runtime == e.key,
                  onSelected: (_) => setState(() => runtime = e.key),
                )).toList(),
              ),
              SizedBox(height: 28.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          genre = null;
                          runtime = null;
                        });
                        widget.onReset();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onGenreChanged(genre);
                        widget.onRuntimeChanged(runtime);
                        widget.onApply();
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}