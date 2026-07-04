import 'package:flutter/material.dart';
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
    if (seasons.isEmpty) {
      return const SizedBox();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<SeasonModel>(
        value: selectedSeason,
        isExpanded: true,
        borderRadius: BorderRadius.circular(16),
        decoration: InputDecoration(
          labelText: "Season",
          prefixIcon: const Icon(Icons.tv_rounded),
          filled: true,
          fillColor: theme.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        items: seasons.map((season) {
          return DropdownMenuItem<SeasonModel>(
            value: season,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    season.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${season.episodeCount} Episodes",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}