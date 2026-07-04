import 'package:flutter/material.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/feature/details/model/season_model.dart';

class SeasonDropdown extends StatelessWidget {
  final List<SeasonModel> seasons;
  final SeasonModel? selectedSeason;
  final ValueChanged<SeasonModel?> onChanged;

  const SeasonDropdown({
    super.key,
    required this.seasons,
    required this.selectedSeason,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF101827),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: const Color(0xFF273244),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: DropdownMenu<SeasonModel>(
            width: MediaQuery.of(context).size.width - 26,
            initialSelection: selectedSeason,
            onSelected: onChanged,
            leadingIcon: const Icon(
              Icons.tv_rounded,
              color: Colors.white,
            ),
            trailingIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
            selectedTrailingIcon: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
            ),
            menuHeight: 300,
            // menuStyle: MenuStyle(
            //   backgroundColor: MaterialStateProperty.all(
            //     const Color(0xFF101827),
            //   ),
            //   shape: MaterialStateProperty.all(
            //     RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // ),
            expandedInsets: EdgeInsets.zero,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFF101827),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            hintText: "Choose Season",
            dropdownMenuEntries: seasons.map((season) {
              return DropdownMenuEntry<SeasonModel>(
                value: season,
                label: season.name,
                trailingIcon: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${season.episodeCount} EP",
                    style: const TextStyle(
                      color: AppColors.textColorDark,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}