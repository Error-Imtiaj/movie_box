import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:movie_box/core/const/app_colors.dart';

class GenreSection extends StatelessWidget {
  final int? selectedGenreId;
  final ValueChanged<int> onGenreSelected;
  final bool useDropdown;

  const GenreSection({
    super.key,
    required this.selectedGenreId,
    required this.onGenreSelected,
    this.useDropdown = false,
  });

  static const List<_GenreItem> _genres = [
    _GenreItem(28, 'Action'),
    _GenreItem(12, 'Adventure'),
    _GenreItem(16, 'Animation'),
    _GenreItem(35, 'Comedy'),
    _GenreItem(80, 'Crime'),
    _GenreItem(18, 'Drama'),
    _GenreItem(10751, 'Family'),
    _GenreItem(14, 'Fantasy'),
    _GenreItem(27, 'Horror'),
    _GenreItem(9648, 'Mystery'),
    _GenreItem(10749, 'Romance'),
    _GenreItem(878, 'Sci-Fi'),
    _GenreItem(53, 'Thriller'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (useDropdown) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: 240.w),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: .45),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: DropdownMenu<int>(
              initialSelection: selectedGenreId,
              hintText: 'Genre',
              expandedInsets: EdgeInsets.zero,
              menuHeight: 320,
              width: 240.w,
              leadingIcon: const Icon(Icons.movie_filter_rounded),
              trailingIcon: const Icon(Icons.keyboard_arrow_down_rounded),
              inputDecorationTheme: const InputDecorationTheme(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                isDense: true,
              ),
              dropdownMenuEntries: _genres
                  .map(
                    (genre) => DropdownMenuEntry<int>(
                      value: genre.id,
                      label: genre.name,
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value != null) {
                  onGenreSelected(value);
                }
              },
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedTicket01,
                size: 20.r,
                color: AppColors.buttonBackgroundColor,
                strokeWidth: 2,
              ),
              SizedBox(width: 8.w),
              Text(
                'Browse by Genre',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: _genres.map((genre) {
              final selected = selectedGenreId == genre.id;

              return ChoiceChip(
                label: Text(genre.name),
                selected: selected,
                onSelected: (_) => onGenreSelected(genre.id),
                selectedColor: AppColors.buttonBackgroundColor,
                backgroundColor: AppColors.cardColor,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                labelStyle: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : AppColors.textColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _GenreItem {
  final int id;
  final String name;

  const _GenreItem(this.id, this.name);
}